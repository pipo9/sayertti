import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/controleurs/contoller.dart';
import 'package:sayertti/controleurs/userController.dart';
import 'package:sayertti/models/user.dart';
import '../../language.dart';
import 'package:sayertti/constants.dart';
import 'package:sayertti/vues/Accueil.dart';
// import 'forgetpassword.dart';
import '../../main.dart';
import 'signup.dart';

class Identifier extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IdentifierState();
}

class _IdentifierState extends State<Identifier> {
  UserController userController = UserController();

  //variable pour afficher la cercle qui tourne en temps de chargement
  bool loading = false;

  final texts = toMap(); // les donnees en format MAP

  //controleur des champs de text
  final emailTextController = TextEditingController();
  final motDePassTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xff202020),
        body: ModalProgressHUD(
            inAsyncCall: loading,
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        height: _height * 0.35,
                        width: _width,
                        decoration: BoxDecoration(color: Color(0xffE61010)),
                        child: Column(
                          children: [
                            InkWell(
                                onTap: () async {
                                  setState(() {
                                    language = (language + 1) % 2;
                                    SharedValues.textDirection = language == 0
                                        ? TextDirection.ltr
                                        : TextDirection.rtl;
                                  });
                                  await saveValueLanguage(language);
                                  main();
                                },
                                child: Align(
                                  alignment: Alignment.bottomRight,
                                  child: Container(
                                    height: _height*0.05,
                                    width: _width*0.23,
                                    margin: EdgeInsets.only(
                                        right: 10,
                                        top: 10,
                                        bottom: _height * 0.07),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(_width * 0.02),
                                    ),
                                    child: Center(
                                        child: Text(
                                          languages[language],
                                          style: TextStyle(
                                              color: Color(0xffE61010)),
                                        )),
                                  )
                                )),
                            Image.asset(
                              "images/logoWhite2.png",
                              height: _height * 0.15,
                            ),
                          ],
                        )),
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    ChampDuTextAuth(
                        textAlign: directions[language],
                        onChanged: (valeur) {
                          setState(() {
                            User.email = valeur;
                          });
                        },
                        controleur: emailTextController,
                        hintText: texts[languages[language]]['email'],
                        icon: Icons.alternate_email_rounded),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    ChampDuTextAuth(
                        onChanged: (valeur) {
                          setState(() {
                            User.password = valeur;
                          });
                        },
                        controleur: motDePassTextController,
                        textAlign: directions[language],
                        hintText: texts[languages[language]]['password'],
                        icon: Icons.lock,
                        obscureText: true),
                    SizedBox(
                      height: _height * 0.08,
                    ),
                    CustomButton(
                      height: _height * 0.06,
                      width: _width * 0.35,
                      text: texts[languages[language]]['signIN'],
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        final response = await userController.signIN(
                            User.email, User.password);
                        if (response['status'] == false)
                          errorDialog(response['message'], context);
                        else {
                          await Controller().initialiseConfig();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Accueil()));
                        }
                        setState(() {
                          loading = false;
                        });
                      },
                      colorInterieur: Color(0xffE61010),
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    CustomButton(
                      height: _height * 0.06,
                      width: _width * 0.35,
                      text: texts[languages[language]]['signUP'],
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Inscrir()));
                      },
                      colorInterieur: Color(0xff202020),
                      colorBorder: Color(0xff707070),
                    ),
                    SizedBox(
                      height: _height * 0.07,
                    ),
                    InkWell(
                      onTap: () {
                        errorDialog('Unsupported Action', context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => OublieLeMotDePass()));
                      },
                      child: Text(
                        texts[languages[language]]['forget'],
                        style: TextStyle(color: Color(0xff707070)),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
