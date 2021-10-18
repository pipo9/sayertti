import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import '../language.dart';
import '../constants.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final texts = toMap(); // les donnees en format MAP
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffF8F8F8),
        appBar: kAppBar(() => Navigator.pop(context), _width * 1.1, _height,
            texts[languages[language]]['orders']),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: _height * 0.02,
            ),
            for (var i = 0; i < SharedValues.orders.length; i++)
              kOrderCard(_height, _width, SharedValues.orders[i], () {
                setState(() {
                  if (SharedValues.orders[i].orderProductsContainerHeight == 0.0)
                    SharedValues.orders[i].orderProductsContainerHeight =
                        _height * SharedValues.orders[i].orderItems.length/11;
                  else
                    SharedValues.orders[i].orderProductsContainerHeight = 0.0;
                });
              }, SharedValues.orders[i].orderProductsContainerHeight*1.1),

              SizedBox(height: _height*0.05,)
          ]),
        ));
  }
}
