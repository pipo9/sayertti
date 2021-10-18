import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/language.dart';
import 'package:sayertti/models/user.dart';
import 'Helpers/Config.dart';
import 'Helpers/HttpClient.dart';
import 'Helpers/tokensHelper.dart';
import 'Helpers/validator.dart';

class UserController {
  HttpClient _httpClient = HttpClient();

  Map _inputValidator(name, email, address, phone, password, rePassword) {
    final texts = toMap(); // les donnees en format MAP
    Map response = Map();
    response['status'] =
        Validator.validatePassword(password, rePassword)['status'];
    response['status'] &= Validator.validateEmail(email)['status'];
    response['status'] &= Validator.validateName(name)['status'];
    response["message"] = '';
    if (Validator.validateName(name)['message'] != '')
      response["message"] +=
          '- ' + Validator.validateName(name)['message'] + "\n";
    if (Validator.validateEmail(email)['message'] != '')
      response["message"] +=
          '- ' + Validator.validateEmail(email)['message'] + "\n";
    if (Validator.validatePassword(password, rePassword)['message'] != '')
      response["message"] += '- ' +
          Validator.validatePassword(password, rePassword)['message'] +
          "\n";
    if (address == null || address == '') {
      response['status'] = false;
      response["message"] += texts[languages[language]]['B-email'];
    }
    if (phone == null || phone == '') {
      response['status'] = false;
      response["message"] += texts[languages[language]]['B-email'];
    }

    return response;
  }

  Future<Map> signUP(name, email, address, phone, password, rePassword) async {
    Map response =
        _inputValidator(name, email, address, phone, password, rePassword);
    if (response['status'] == true) {
      var body = {
        "email": email,
        "password": password,
        "confirmPassword": password,
        "phoneNumber": phone,
        "address": address
      };
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      response = await _httpClient.postRequest(Urls.signUPPath, headers, body);
      print(response);
      if (response['status'] == true)
        await TokenHelper.saveLocalTokens(
            response['body']["accessToken"], response['body']["refreshToken"]);
        await getUserDetails();
    }
    return response;
  }

  Future<Map> signIN(email, password) async {
    Map response =
        _inputValidator("pass", email, 'address', 'phone', password, password);
    if (response['status'] == true) {
      var body = {
        "login": email,
        "password": password,
      };
      var headers = <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      };
      response = await _httpClient.postRequest(Urls.signINPath, headers, body);
      if (response['status'] == true)
        await TokenHelper.saveLocalTokens(
            response['body']["accessToken"], response['body']["refreshToken"]);
      await getUserDetails();
    }
    return response;
  }

  signOut() async {
    await TokenHelper.saveLocalTokens('', '');
    User.setValues('', '', '', '', [], '', '');
  }

  getUserDetails() async {
    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };

    var response = await _httpClient.getRequest(Urls.userInfoPath, headers);

    if (response["status"] == true) {
      User.setValues(
          response["body"]["id"],
          response["body"]["name"],
          response["body"]["email"],
          response["body"]["phoneNumber"],
          response["body"]["address"],
          response["body"]["activeCartId"],
          response["body"]["chatId"]);
      return true;
    }
    return false;
  }

  Future<Map> checkUserTokens() async {
    Map response = Map();
    final tokens = await TokenHelper.getLocalTokens();
    if (tokens["accessToken"] == '') {
      response['status'] = false;
      response['message'] = "NO tokens";
      return response;
    }
    final tokenStatus = await getUserDetails();
    if (tokenStatus == false) {
      response['status'] = false;
      response['message'] = "Jwt expired";
      await new TokenHelper().refreshTokens();
    } else {
      response['status'] = true;
      response['message'] = "all is ok";
    }

    return response;
  }

  updateUserInfo() async {
    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };
    var body = {
      "address": User.address,
      "phoneNumber": User.phone,
      "email": User.email,
      "name": User.name,
    };

    var response = await _httpClient.putRequest(
        '${Urls.userUpdateInfo}/${User.id}', headers, body);
    if (response["status"] == true) {
      await getUserDetails();
    }
    return false;
  }

  getCodeToResetPassword(email) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var body = {
      "email": email,
    };
    var response =
        await _httpClient.postRequest(Urls.resetPassword, headers, body);
    if (response["status"] == true) {
      SharedValues.resetPasswordCode = response['body']['code'];
      return true;
    }
    return false;
  }

  resetPassword(email, password) async {
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
    };
    var body = {"email": email, "password": password};
    var response =
        await _httpClient.postRequest(Urls.resetPassword, headers, body);
    if (response["status"] == true) {
      return true;
    }
    return false;
  }
}
