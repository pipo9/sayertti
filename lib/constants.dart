import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayertti/models/order.dart';
import 'controleurs/Helpers/sharedValues.dart';
import 'language.dart';

// Colors
const kLightGrey = Color(0xffF8F8F8);
const kColorRed = Color(0xffE61010);
const kDarkText = Color(0xff202020);
const kDarkGrey = Color(0xff707070);

//Fonts
FontWeight kfontWeight = FontWeight.normal;

AppBar kAppBar(onTap, width, height, text) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: IconButton(
      icon: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.red, borderRadius: BorderRadius.circular(50)),
        child: Icon(Icons.arrow_back),
      ),
      onPressed: onTap,
    ),
    title: Center(
      child: Padding(
        padding: EdgeInsets.only(right: width * 0.1),
        child: Text(
          text,
          style: GoogleFonts.robotoSlab(
            color: Colors.black,
            fontSize: height * 0.028,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget kButtonSettings(height, width, onTap, text) {
  return Align(
    alignment: Alignment.center,
    child: InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: height * 0.02),
        height: height * 0.055,
        width: width * 0.8,
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
          borderRadius: BorderRadius.circular(width * 0.02),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.03),
          child: Row(
              textDirection: SharedValues.textDirection,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: height * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  language == 0
                      ? Icons.arrow_forward_ios
                      : Icons.arrow_back_ios,
                  color: Colors.white,
                  size: width * 0.04,
                ),
              ]),
        ),
      ),
    ),
  );
}

Widget kOrderCard(height, width, Order order, onTap, containerHeight) {
  const orderStatusNamesFr = [
    "en attente",
    "en cours de traitement",
    "expédié",
    "livré"
  ];
  const orderStatusNamesAr = ["قيد الانتظار", " طور المعالجة", "أرسل", " سلم"];
  const orderStatusColors = [
    Colors.white70,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.greenAccent
  ];
  const orderStatusBorderColors = [
    Colors.grey,
    Colors.blue,
    Colors.red,
    Colors.green
  ];
  final texts = toMap();

  return Align(
      alignment: Alignment.center,
      child: InkWell(
          onTap: onTap,
          child: Column(children: [
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: height * 0.01, horizontal: width * 0.01),
              height: height * 0.085,
              width: width * 0.95,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 0.1,
                        blurRadius: 6,
                        offset: Offset(0, 5))
                  ]),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                child: Row(
                  textDirection: SharedValues.textDirection,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      order.orderId,
                      style: GoogleFonts.robotoSlab(
                        color: Colors.black,
                        fontSize: height * 0.020,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      textDirection: SharedValues.textDirection,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: height * 0.05,
                          child: Center(
                              child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: width * 0.03),
                                  child: Text(
                                      language == 0
                                          ? orderStatusNamesFr[
                                              order.orderStatus]
                                          : orderStatusNamesAr[
                                              order.orderStatus],
                                      style: GoogleFonts.robotoSlab(
                                        color: Colors.black,
                                        fontSize: height * 0.016,
                                        fontWeight: FontWeight.w500,
                                      )))),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.03),
                              color: orderStatusColors[order.orderStatus],
                              border: Border.all(
                                  color: orderStatusBorderColors[
                                      order.orderStatus])),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: kColorRed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: containerHeight,
                width: width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.03),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    for (int i = 0; i < order.orderItems.length; i++)
                      Expanded(
                          child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: width * 0.03, vertical: height * 0.01),
                        child: Row(
                          textDirection: SharedValues.textDirection,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                language == 0
                                    ? order.orderItems[i].productNameFr
                                    : order.orderItems[i].productNameAr,
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.black,
                                  fontSize: height * 0.020,
                                  fontWeight: FontWeight.w600,
                                )),
                            Text(
                                order.orderItems[i].productPromotion == '0'
                                    ? "${order.orderItems[i].productPrice} * ${order.orderItems[i].productQuantity}"
                                    : "${order.orderItems[i].productPromotedPrice} * ${order.orderItems[i].productQuantity}",
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.black,
                                  fontSize: height * 0.020,
                                  fontWeight: FontWeight.w600,
                                )),
                          ],
                        ),
                      )),
                    Expanded(
                        child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: width * 0.03, vertical: height * 0.01),
                      child: Row(
                        textDirection: SharedValues.textDirection,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(texts[languages[language]]['total'],
                              style: GoogleFonts.robotoSlab(
                                color: Colors.black,
                                fontSize: height * 0.020,
                                fontWeight: FontWeight.w600,
                              )),
                          Text("${order.orderPrice}",
                              style: GoogleFonts.robotoSlab(
                                color: Colors.black,
                                fontSize: height * 0.020,
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                    )),
                  ],
                ))
          ])));
}

Widget kCartCard(
    height, width, image, productName, price, number, onAdd, onMin) {
  return Align(
    alignment: Alignment.center,
    child: Container(
      margin: EdgeInsets.only(top: height * 0.02),
      height: height * 0.18,
      width: width * 0.95,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.05),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 0.1,
                blurRadius: 6,
                offset: Offset(0, 5))
          ]),
      child: Row(
        textDirection: SharedValues.textDirection,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.network(
            image,
            width: width * 0.4,
            height: height * 0.17,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                productName,
                style: GoogleFonts.robotoSlab(
                  color: Colors.black,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Row(
                children: [
                  Text(
                    price + "\$",
                    style: GoogleFonts.robotoSlab(
                      color: Colors.black,
                      fontSize: height * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: width * 0.3,
                    margin: EdgeInsets.only(left: width * 0.1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: height * 0.006, horizontal: width * 0.03),
                      child: Row(
                        textDirection: SharedValues.textDirection,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: onMin,
                            child: Container(
                              height: height * 0.03,
                              width: width * 0.05,
                              child: Center(
                                child: Text(
                                  '-',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.04,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  color: kColorRed),
                            ),
                          ),
                          Text(
                            number.toString(),
                            style: GoogleFonts.robotoSlab(
                                color: Colors.black,
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: onAdd,
                            child: Container(
                              height: height * 0.03,
                              width: width * 0.05,
                              child: Center(
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.025,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.circular(width * 0.1),
                                  color: kColorRed),
                            ),
                          )
                        ],
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(width * 0.1),
                        border: Border.all(color: kColorRed)),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}

AppBar kHomeAppBar(
    language, firstOnTap, width, textController, onChanged, lastOnTap) {
  return AppBar(
    backgroundColor: Colors.white,
    leading: InkWell(
      onTap: firstOnTap,
      child: Icon(
        Icons.person,
        color: Colors.black,
      ),
    ),
    actions: [
      Container(
        width: width * 0.7,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 2,
          ),
          child: TextField(
            controller: textController,
            onChanged: onChanged,
            textAlign: language == 0 ? TextAlign.left : TextAlign.right,
            cursorColor: Color(0xff707070),
            style: TextStyle(color: Color(0xff707070)),
            decoration: new InputDecoration(
              contentPadding: EdgeInsets.only(top: 20, left: width * 0.05),
              hintText: language == 0 ? "search" : "البحت",
              hintStyle: new TextStyle(color: Color(0xff707070)),
              border: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: new BorderSide(color: Color(0xff707070))),
              focusedBorder: new OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: new BorderSide(color: Color(0xff707070))),
              suffixIcon: Icon(
                Icons.search,
                color: Colors.black12,
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        width: width * 0.06,
      ),
      InkWell(
        onTap: lastOnTap,
        child: Icon(
          Icons.message,
          color: Colors.black,
        ),
      ),
      SizedBox(
        width: width * 0.04,
      ),
    ],
  );
}

Widget kUserMessage(height, width, text) {
  return Align(
    alignment: Alignment.centerRight,
    child: Container(
      width: width * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(width * 0.03),
            bottomRight: Radius.circular(width * 0.03),
            bottomLeft: Radius.circular(width * 0.03),
          ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0.1,
                blurRadius: 5,
                offset: Offset(0, 3))
          ]),
      margin: EdgeInsets.only(top: height * 0.03, right: width * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: Text(
          text,
          style: GoogleFonts.robotoSlab(
              fontSize: height * 0.018, fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

Widget kSupportMessage(height, width, text) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Container(
      width: width * 0.6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(width * 0.03),
            bottomRight: Radius.circular(width * 0.03),
            bottomLeft: Radius.circular(width * 0.03),
          ),
          color: kColorRed,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0.1,
                blurRadius: 5,
                offset: Offset(0, 3))
          ]),
      margin: EdgeInsets.only(top: height * 0.03, left: width * 0.03),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.02),
        child: Text(
          text,
          style: GoogleFonts.robotoSlab(
              color: Colors.white,
              fontSize: height * 0.018,
              fontWeight: FontWeight.bold),
        ),
      ),
    ),
  );
}

errorDialog(text, context) {
  final texts = toMap();
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
                width: _width * 0.5,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Error",
                        style: GoogleFonts.robotoSlab(
                          color: kColorRed,
                          fontSize: _height * 0.02,
                          fontWeight: kfontWeight,
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Text(
                        text,
                        style: GoogleFonts.robotoSlab(
                          color: Colors.white70,
                          fontSize: _height * 0.025,
                          fontWeight: kfontWeight,
                        ),
                      ),
                      SizedBox(
                        height: _height * 0.02,
                      ),
                      Align(
                        child: CustomButton(
                            colorInterieur: kColorRed,
                            text: texts[languages[language]]['done'],
                            onTap: () => Navigator.pop(context),
                            height: _height * 0.05,
                            width: _width * 0.3),
                      ),
                    ],
                  ),
                )));
      });
}

class CustomButton extends StatelessWidget {
  CustomButton(
      {@required this.text,
      this.colorInterieur,
      this.colorBorder = Colors.transparent,
      @required this.onTap,
      this.height,
      this.width});

  final String text;
  final Color colorInterieur;
  final Color colorBorder;
  final onTap;
  final height;
  final width;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: colorInterieur,
          borderRadius: BorderRadius.circular(width * 0.1),
          border: Border.all(color: colorBorder),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ChampDuTextAuth extends StatelessWidget {
  ChampDuTextAuth(
      {@required this.hintText,
      @required this.icon,
      this.textAlign = TextAlign.left,
      this.controleur,
      this.onChanged,
      this.enabled = true,
      this.obscureText = false,
      this.textInputType = TextInputType.text});

  final String hintText;
  final IconData icon;
  final TextAlign textAlign;
  final TextEditingController controleur;
  final onChanged;
  final enabled;
  final obscureText;
  final textInputType;
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width * 0.8,
      child: TextField(
        keyboardType: textInputType,
        obscureText: obscureText,
        enabled: enabled,
        onChanged: onChanged,
        controller: controleur,
        textAlign: textAlign,
        cursorColor: Color(0xff707070),
        style: TextStyle(color: Color(0xff707070)),
        decoration: new InputDecoration(
          contentPadding: EdgeInsets.only(top: 15),
          hintText: hintText,
          hintStyle: new TextStyle(color: Color(0xff707070)),
          border: new UnderlineInputBorder(
              borderSide: new BorderSide(color: Color(0xff707070))),
          focusedBorder: new UnderlineInputBorder(
              borderSide: new BorderSide(color: Color(0xff707070))),
          prefixIcon: Icon(
            icon,
            color: Color(0xff707070),
          ),
        ),
      ),
    );
  }
}
