

import 'package:sayertti/controleurs/Helpers/HttpClient.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Config.dart';


class TokenHelper{

  HttpClient _httpClient = HttpClient();

 static saveLocalTokens(accessToken, refreshToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('accessToken', accessToken);
    prefs.setString('refreshToken', refreshToken);
  }

///// get language and direction
  static  getLocalTokens() async {
    Map<String,String> tokens = Map();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tokens["refreshToken"] = prefs.getString('refreshToken') == null
        ? ''
        : prefs.getString('refreshToken');
    tokens["accessToken"] = prefs.getString('accessToken') == null
        ? ''
        : prefs.getString('accessToken');
    return tokens;
  }

  refreshTokens() async{
    final tokens = await getLocalTokens();

    var body = {
      "refreshToken": tokens["refreshToken"]
    };
    Map<String,String> header = new Map();

    var response = await _httpClient.postRequest(Urls.refreshTokens,header,body);
    if(response['status']==true) {
      await saveLocalTokens(
          response['body']["accessToken"], response['body']["refreshToken"]);
    }
  }


}