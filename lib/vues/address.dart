import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sayertti/constants.dart';
import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/controleurs/userController.dart';
import 'package:sayertti/models/user.dart';
import '../language.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final texts = toMap();

  //variable pour afficher la cercle qui tourne en temps de chargement
  bool loading = false;

  String addressText;
  final addressTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: kAppBar(() => Navigator.pop(context), _width, _height,
          texts[languages[language]]['address']),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: _height * 0.751,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      for (String address in User.address)
                        addressContainer(address, () async {
                          User.address.remove(address);
                          await UserController().updateUserInfo();
                          setState(() {});
                        }),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: _height * 0.1,
                child: Padding(
                  padding: EdgeInsets.only(left: _width * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: _width * 0.8,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 2,
                          ),
                          child: TextField(
                            controller: addressTextController,
                            onChanged: (value) {
                              setState(() {
                                addressText = value;
                              });
                            },
                            textAlign: language == 0
                                ? TextAlign.left
                                : TextAlign.right,
                            cursorColor: Color(0xff707070),
                            style: TextStyle(color: Color(0xff707070)),
                            decoration: new InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.only(
                                  top: 20,
                                  left: _width * 0.05,
                                  right: _width * 0.05),
                              hintText:
                                  language == 0 ? "Ecrire..." : "اأكتب...",
                              hintStyle:
                                  new TextStyle(color: Color(0xff707070)),
                              border: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      new BorderSide(color: Color(0xff707070))),
                              focusedBorder: new OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide:
                                      new BorderSide(color: Color(0xff707070))),
                            ),
                            maxLength: 30,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          setState(() {
                            loading = true;
                          });
                          User.address.add(addressText);
                          print(User.address);
                          addressTextController.clear();
                          await UserController().updateUserInfo();
                          setState(() {
                            loading = false;
                          });
                        },
                        iconSize: 30.0,
                        padding: EdgeInsets.only(right: _width * 0.07),
                        icon: Icon(
                          Icons.add_location_alt_outlined,
                          size: _width * 0.09,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget addressContainer(text, onClick) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: _height * 0.07,
        width: _width * 0.95,
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: _height * 0.001, horizontal: _width * 0.01),
          child: Row(
            textDirection: SharedValues.textDirection,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.robotoSlab(
                    fontSize: _height * 0.023, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: onClick,
                icon: Icon(Icons.delete_outline),
                color: kColorRed,
                iconSize: _width * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
