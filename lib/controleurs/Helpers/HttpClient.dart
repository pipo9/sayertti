import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import '../../language.dart';
import 'Config.dart';
import 'tokensHelper.dart';

class HttpClient {
  HttpClient._privateConstructor();
  final texts = toMap(); // les donnees en format MAP

  static final HttpClient _instance = HttpClient._privateConstructor();

  factory HttpClient() {
    return _instance;
  }

  Future<dynamic> getRequest(String path, headers) async {
    var response;
    Map returnedResponse = Map();
    returnedResponse["status"] = false;
    returnedResponse["body"] = texts[languages[language]]['E-error'];

    try {
      response = await get(
        Uri.https(Urls.ApiPath, path),
        headers: headers,
      );
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.body.isEmpty) {
          returnedResponse["status"] = false;
          // returnedResponse["body"] = [];
        } else {
          returnedResponse["status"] = true;
           returnedResponse["body"] = jsonDecode(response.body);
        }
      }
      if (statusCode == 401) {
        final message = jsonDecode(response.body)["error"]['message'];
        if (message == "jwt expired") {
          await new TokenHelper().refreshTokens();
          var tokens = TokenHelper.getLocalTokens();
          Map<String, String> header = {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${tokens['accessToken']}'
          };
          returnedResponse = await getRequest(path, header);
        }
      }
    } on SocketException {
      returnedResponse["body"] = texts[languages[language]]['E-connection'];
    }
    return returnedResponse;
  }

  Future<dynamic> postRequest(String path, headers, body) async {
    Response response;
    Map returnedResponse = Map();
    returnedResponse["status"] = false;
    returnedResponse["message"] = texts[languages[language]]['E-error'];

    try {
      response = await post(
        Uri.https(Urls.ApiPath, path),
        headers: headers,
        body: jsonEncode(body),
      );
      print('body:${response.body}');
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.body.isEmpty) {
          returnedResponse["status"] = false;
          returnedResponse["body"] = [];
        } else {
          returnedResponse["status"] = true;
          returnedResponse["body"] = jsonDecode(response.body);
          returnedResponse["message"] ='ok';
        }
      }
      if (statusCode == 401) {
        final message = jsonDecode(response.body)["error"]['message'];
        if (message == "Invalid password") {
          returnedResponse["message"] =
              texts[languages[language]]['invalid-pass'];
        }
        if (message == "User not found") {
          returnedResponse["message"] =
              texts[languages[language]]['x-user'];
        }
        if (message == "jwt expired") {
          await new TokenHelper().refreshTokens();
          var tokens = TokenHelper.getLocalTokens();
          Map<String, String> header = {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${tokens['accessToken']}'
          };
          returnedResponse = await postRequest(path, header, body);
        }
      }
    } on SocketException {
      returnedResponse["message"] = texts[languages[language]]['E-connection'];
    }
    return returnedResponse;
  }

  Future<dynamic> putRequest(String path, headers, body) async {
    Response response;
    Map returnedResponse = Map();
    returnedResponse["status"] = false;
    returnedResponse["message"] = texts[languages[language]]['E-error'];

    try {
      response = await patch(
        Uri.https(Urls.ApiPath, path),
        headers: headers,
        body: jsonEncode(body),
      );
      print('body:${response.body}');
      final statusCode = response.statusCode;
      if (statusCode >= 200 && statusCode < 299) {
        if (response.body.isEmpty) {
          returnedResponse["status"] = false;
        } else {
          returnedResponse["status"] = true;
        }
      }
      if (statusCode == 401) {
        final message = jsonDecode(response.body)["error"]['message'];
        if (message == "jwt expired") {
          await new TokenHelper().refreshTokens();
          var tokens = TokenHelper.getLocalTokens();
          Map<String, String> header = {
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${tokens['accessToken']}'
          };
          returnedResponse = await putRequest(path, header, body);
        }
      }
    } on SocketException {
      returnedResponse["message"] = texts[languages[language]]['E-connection'];
    }
    return returnedResponse;
  }

}
