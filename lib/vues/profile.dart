import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sayertti/controleurs/userController.dart';
import 'package:sayertti/models/user.dart';
import '../language.dart';

import 'package:sayertti/constants.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //control si l'utilisateus peuvent change les infos
  var enabled = false;
  //variable pour afficher la cercle qui tourne en temps de chargement
  bool loading = false;

  final texts = toMap(); // les donnees en format MAP
  String email;
  String name;
  String phone;
  //controleur des champs de text
  final emailTextController = TextEditingController();
  final nameTextController = TextEditingController();
  final phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: kAppBar(() => Navigator.pop(context), _width, _height,
          texts[languages[language]]['profile']),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: Align(
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(children: [
              ChampDuTextAuth(
                  enabled: enabled,
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  textAlign: directions[language],
                  controleur: nameTextController,
                  hintText: User.name,
                  icon: Icons.person),
              SizedBox(
                height: _height * 0.04,
              ),
              ChampDuTextAuth(
                  enabled: enabled,
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  textAlign: directions[language],
                  controleur: emailTextController,
                  hintText: User.email,
                  icon: Icons.alternate_email_rounded),
              SizedBox(
                height: _height * 0.04,
              ),
              ChampDuTextAuth(
                enabled: enabled,
                onChanged: (value) {
                  setState(() {
                    phone = value;
                  });
                },
                textAlign: directions[language],
                controleur: phoneTextController,
                hintText: User.phone,
                icon: Icons.phone,
              ),
              SizedBox(
                height: _height * 0.1,
              ),
              CustomButton(
                height: _height * 0.06,
                width: _width * 0.5,
                text: texts[languages[language]]['edit'],
                onTap: () {
                  setState(() {
                    enabled = !enabled;
                  });
                },
                colorInterieur: kColorRed,
              ),
              SizedBox(
                height: _height * 0.01,
              ),
              CustomButton(
                height: _height * 0.06,
                width: _width * 0.5,
                text: texts[languages[language]]['update'],
                onTap: () async {
                  setState(() {
                    loading = true;
                    email!=null ? User.setEmail(email): User.setEmail(User.email);
                    phone!=null ? User.setPhone(phone): User.setPhone(User.phone);
                    name!=null ? User.setName(name): User.setName(User.name);
                  });
                  await UserController().updateUserInfo();
                  setState(() {
                    loading = false;
                  });
                },
                colorInterieur: kDarkText,
                colorBorder: Colors.transparent,
              ),
              SizedBox(
                height: _height * 0.04,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
