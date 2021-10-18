import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayertti/constants.dart';
import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/controleurs/userController.dart';
import 'package:sayertti/language.dart';
import 'package:sayertti/main.dart';
import 'package:sayertti/vues/address.dart';
import 'package:sayertti/vues/auth/signin.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool chargement =
      false; //variable pour afficher la cercle qui tourne en temps de chargement
  final texts = toMap(); // les donnees en format MAP

  //controleur des champs de text
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final motDePassTextController = TextEditingController();
  final reMotDePassTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: kAppBar(() => Navigator.pop(context), _width, _height,
          texts[languages[language]]['settings']),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: _height * 0.1,
          ),
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () async {
                setState(() {
                  language = (language + 1) % 2;
                  SharedValues.textDirection =
                      language == 0 ? TextDirection.ltr : TextDirection.rtl;
                });
                await saveValueLanguage(language);
                main();
              },
              child: Container(
                margin: EdgeInsets.only(top: _height * 0.02),
                height: _height * 0.055,
                width: _width * 0.8,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.2, 0.9],
                    colors: [
                      kColorRed,
                      kDarkText,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(_width * 0.02),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width * 0.03),
                  child: Row(
                      textDirection: SharedValues.textDirection,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          texts[languages[language]]['language'],
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            fontSize: _height * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          language == 0 ? "francais" : "العربية",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            fontSize: _height * 0.02,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ),
          kButtonSettings(_height, _width, () {
            dialog(texts[languages[language]]['privacy'], 'hello all');
          }, texts[languages[language]]['privacy']),
          kButtonSettings(_height, _width, () {
            dialog(texts[languages[language]]['about'], 'hello all');
          }, texts[languages[language]]['about']),
          kButtonSettings(_height, _width, () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Address()));
          }, texts[languages[language]]['address']),
          kButtonSettings(_height, _width, () async {
            await new UserController().signOut();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => Identifier()),
                (Route<dynamic> route) => false);
          }, texts[languages[language]]['logout']),
        ]),
      ),
    );
  }

  dialog(setting, text) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: Container(
                  height: _height * 0.5,
                  width: _width * 0.5,
                  child: Column(
                    children: [
                      Text(
                        setting,
                        style: GoogleFonts.robotoSlab(
                          color: kColorRed,
                          fontSize: _height * 0.025,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Container(
                        height: _height * 0.36,
                        width: _width * 0.5,
                        child: ListView(children: [
                          Text(
                            text,
                            style: GoogleFonts.robotoSlab(
                              color: kDarkText,
                              fontSize: _height * 0.015,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      CustomButton(
                          colorInterieur: kColorRed,
                          text: texts[languages[language]]['ok'],
                          onTap: () => Navigator.pop(context),
                          height: _height * 0.05,
                          width: _width * 0.3)
                    ],
                  )));
        });
  }
}
