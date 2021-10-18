import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sayertti/controleurs/Helpers/validator.dart';
import 'package:sayertti/controleurs/userController.dart';
import '../../language.dart';
import 'package:sayertti/constants.dart';
import 'signin.dart';

class OublieLeMotDePass extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OublieLeMotDePassState();
}

class _OublieLeMotDePassState extends State<OublieLeMotDePass> {
  //variable pour afficher la cercle qui tourne en temps de chargement
  bool loading = false;
  final texts = toMap(); // es donnees en format MAP

  //controleur des champs de text
  String email;
  final emailTextController = TextEditingController();
  String code;
  final codeTextController = TextEditingController();
  String password;
  final passwordTextController = TextEditingController();
  // contoleur de l'utilisateurs

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
                      child:
                          Center(child: Image.asset("images/logoWhite2.png",height: _height * 0.15)),
                    ),
                    SizedBox(
                      height: _height * 0.08,
                    ),
                    ChampDuTextAuth(
                        controleur: emailTextController,
                        onChanged: (value) {
                          setState(() {
                            email=value;
                          });
                        },
                        textAlign: directions[language],
                        hintText: texts[languages[language]]['email'],
                        icon: Icons.alternate_email_rounded),
                    SizedBox(
                      height: _height * 0.11,
                    ),
                    CustomButton(
                      height: _height * 0.06,
                      width: _width * 0.35,
                      text: texts[languages[language]]['send'],
                      onTap:()async{
                        setState(() {
                          loading=true;
                        });
                        var checkEmail=Validator.validateEmail(email);
                        if(checkEmail['status']==true) {
                          var response =
                          await UserController()
                              .getCodeToResetPassword(email);
                          if (response == true) {
                            setCodeDialog();
                          }

                        }
                        else{
                          errorDialog(checkEmail['message'], context);
                        }
                        setState(() {
                          loading=false;
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
                      text: texts[languages[language]]['signIN'],
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Identifier()));
                      },
                      colorInterieur: Color(0xff202020),
                      colorBorder: Color(0xff707070),
                    ),
                  ],
                ),
              ),
            )));
  }
  setCodeDialog() {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: kDarkText,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: Container(
                  height: _height * 0.3,
                  width: _width * 0.7,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [

                        SizedBox(
                          height: _height * 0.05,
                        ),
                        ChampDuTextAuth(
                            controleur: codeTextController,
                            onChanged: (value) {
                              setState(() {
                                code=value;
                              });
                            },
                            textAlign: directions[language],
                            hintText: texts[languages[language]]['code'],
                            icon: Icons.vpn_key_outlined),
                        SizedBox(
                          height: _height * 0.07,
                        ),
                        CustomButton(
                          height: _height * 0.06,
                          width: _width * 0.35,
                          text: texts[languages[language]]['ok'],
                          onTap:()async{
                            setState(() {
                              loading=true;
                            });

                              Navigator.pop(context);
                              setPasswordDialog();

                            setState(() {
                              loading=false;
                            });
                          },
                          colorInterieur: Color(0xffE61010),
                        ),
                      ],
                    )
                  )));
        });
  }
  setPasswordDialog() {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              backgroundColor: kDarkText,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              content: Container(
                  height: _height * 0.3,
                  width: _width * 0.7,
                  child: SingleChildScrollView(
                      child: Column(
                        children: [

                          SizedBox(
                            height: _height * 0.05,
                          ),
                          ChampDuTextAuth(
                              textAlign: directions[language],
                              onChanged: (value) {
                                setState(() {
                                  password=value;
                                });
                              },
                              controleur: passwordTextController,
                              hintText: texts[languages[language]]['password'],
                              icon: Icons.lock,
                              obscureText:true),
                          SizedBox(
                            height: _height * 0.07,
                          ),
                          CustomButton(
                            height: _height * 0.06,
                            width: _width * 0.35,
                            text: texts[languages[language]]['send'],
                            onTap:()async{
                              setState(() {
                                loading=true;
                              });

                              Navigator.pop(context);
                              setPasswordDialog();

                              setState(() {
                                loading=false;
                              });
                            },
                            colorInterieur: Color(0xffE61010),
                          ),
                        ],
                      )
                  )));
        });
  }
}
