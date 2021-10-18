import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sayertti/controleurs/contoller.dart';
import 'package:sayertti/vues/Accueil.dart';
import 'auth/signin.dart';
import 'package:sayertti/controleurs/userController.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  UserController userController = UserController();
  Map response = Map();

  @override
  void initState(){
    super.initState();
   userController.checkUserTokens().then((response) async{
     if(response["status"]==true) {
       await Controller().initialiseConfig();
     }
     Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>response["status"]==false?Identifier():Accueil()));
   });

  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: _height * 0.6,
          width: _width * 0.8,
          child: Image.asset('images/logoRed2.png'),
        ),
      ),
    );
  }
}
