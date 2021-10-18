import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sayertti/constants.dart';
import 'package:sayertti/controleurs/contoller.dart';
import 'package:sayertti/controleurs/userController.dart';
import 'package:sayertti/models/user.dart';
import 'package:sayertti/vues/Accueil.dart';
import '../../language.dart';
import 'signin.dart';



class Inscrir extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _InscrirState();
}


class _InscrirState extends State<Inscrir> {

   UserController userController=UserController();

   //variable pour afficher la cercle qui tourne en temps de chargement
  bool loading = false;

  final texts = toMap(); // les donnees en format MAP

  //controleur des champs de text
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final motDePassTextController = TextEditingController();
  final reMotDePassTextController = TextEditingController();
  final phoneTextController = TextEditingController();

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
                          Center(child: Image.asset("images/logoWhite2.png", height: _height * 0.15)),
                    ),
                    SizedBox(
                      height: _height * 0.05,
                    ),
                    ChampDuTextAuth(
                        textAlign: directions[language],
                        onChanged: (valeur) {
                          setState(() {
                            User.name=valeur;
                          });
                        },
                        controleur: nameTextController,
                        hintText: texts[languages[language]]['name'],
                        icon: Icons.person),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    ChampDuTextAuth(
                        textAlign: directions[language],
                        onChanged: (valeur) {
                          setState(() {
                            User.email=valeur;
                          });
                        },
                        controleur: emailTextController,
                        hintText: texts[languages[language]]['email'],
                        icon: Icons.alternate_email_rounded),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    ChampDuTextAuth(
                        textAlign: directions[language],
                        onChanged: (valeur) {
                          setState(() {
                            User.phone=valeur;
                          });
                        },
                        controleur: phoneTextController,
                        hintText: texts[languages[language]]['phone'],
                        icon: Icons.phone),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    ChampDuTextAuth(
                        textAlign: directions[language],
                        onChanged: (valeur) {
                          setState(() {
                            User.password=valeur;
                          });
                        },
                        controleur: motDePassTextController,
                        hintText: texts[languages[language]]['password'],
                        icon: Icons.lock,
                        obscureText:true),
                    SizedBox(
                      height: _height * 0.02,
                    ),
                    ChampDuTextAuth(
                        textAlign: directions[language],
                        onChanged: (valeur) {
                          setState(() {
                            User.rePassword=valeur;
                          });
                        },
                        controleur: reMotDePassTextController,
                        hintText: texts[languages[language]]['password'],
                        icon: Icons.lock,
                        obscureText:true),
                    SizedBox(
                      height: _height * 0.08,
                    ),
                    CustomButton(
                      height: _height * 0.06,
                      width: _width * 0.35,
                      text: texts[languages[language]]['signUP'],
                      onTap: () async {
                        setState(() {
                          loading=true;
                        });
                        final response=await userController.signUP(User.name,User.email,User.address,User.phone,User.password,User.rePassword);
                        setState(() {
                          loading=false;
                        });
                        if(response['status']==false)
                          errorDialog(response['message'],context);
                        else{
                          await Controller().initialiseConfig();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Accueil()));
                      }
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
                    SizedBox(
                      height: _height * 0.04,
                    ),
                  ],
                ),
              ),
            )));
  }


}
