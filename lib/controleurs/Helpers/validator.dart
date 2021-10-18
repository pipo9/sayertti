
import '../../language.dart';

class Validator {

  static Map validateName(name) {
    final texts = toMap(); // les donnees en format MAP

    Map response = Map();
    if(name.isEmpty){
      response['status'] = false;
      response['message'] = texts[languages[language]]['E-name'];
      return response;
    }
    response['status'] = true;
    response['message'] = "";
    return response;
  }
  static Map validateEmail(email) {
    final texts = toMap(); // les donnees en format MAP
    Map response = Map();
    if(email==null){
      response['status'] = false;
      response['message'] = texts[languages[language]]['E-name'];
      return response;
    }
    if(!RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
      response['status'] = false;
      response['message'] = texts[languages[language]]['B-email'];
      return response;
    }
    response['status'] = true;
    response['message'] = "";
    return response;
  }
  static Map validatePassword(password,rePassword) {
    final texts = toMap(); // les donnees en format MAP

    Map response = Map();
    if (password==null || password.isEmpty || password.length < 8) {
      response['status'] = false;
      response['message'] = texts[languages[language]]['R-pass'];
      return response;
    }
    if (password!=rePassword) {
      response['status'] = false;
      response['message'] = texts[languages[language]]['E-pass'];
      return response;
    }
    response['status'] = true;
    response['message'] = "";
    return response;
  }

}
