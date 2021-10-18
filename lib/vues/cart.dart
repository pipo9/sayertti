import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/controleurs/cartController.dart';
import 'package:sayertti/models/product.dart';
import 'package:sayertti/models/user.dart';
import 'package:sayertti/vues/Demarrage.dart';
import '../language.dart';
import '../constants.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  final texts = toMap(); // les donnees en format MAP
  int counter = 1;
  int selected = 0;
  String phone;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffF8F8F8),
        appBar: kAppBar(() => Navigator.pop(context), _width, _height,
            texts[languages[language]]['cart']),
        body: ModalProgressHUD(
          inAsyncCall: loading,
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Text(
                    texts[languages[language]]['check'],
                    style: GoogleFonts.robotoSlab(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Container(
                    height: 1,
                    width: _width * 0.15,
                    color: kColorRed,
                  ),
                  SizedBox(
                    height: _height * 0.01,
                  ),
                  Container(
                    height: _height * 0.65,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          for (Product product in SharedValues.cart)
                            Slidable(
                              child: kCartCard(
                                _height,
                                _width,
                                product.productImageUrl,
                                product.productNameFr,
                                product.productPromotion == '0'
                                    ? product.productPrice
                                    : product.productPromotedPrice.toString(),
                                product.productQuantity,
                                () {
                                  setState(() {
                                    product.productQuantity++;
                                    if (product.productPromotion == '0')
                                      SharedValues.sumCart +=
                                          double.parse(product.productPrice);
                                    else
                                      SharedValues.sumCart +=
                                          product.productPromotedPrice;
                                  });
                                },
                                () {
                                  setState(() {
                                    if (product.productQuantity > 1) {
                                      product.productQuantity--;
                                      SharedValues.sumCart -=
                                          double.parse(product.productPrice);
                                    }
                                  });
                                },
                              ),
                              actionPane: SlidableDrawerActionPane(),
                              actionExtentRatio: 0.2,
                              secondaryActions: <Widget>[
                                IconSlideAction(
                                  caption: texts[languages[language]]['delete'],
                                  color: Colors.transparent,
                                  icon: Icons.delete,
                                  onTap: () async {
                                    await new CartController()
                                        .deleteFromCart(product);
                                    setState(() {});
                                  },
                                  foregroundColor: Colors.black,
                                ),
                              ],
                            ),
                          SizedBox(
                            height: _height * 0.03,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: _height * 0.02,
                  ),
                  Container(
                    child: Column(
                      children: [
                        Container(
                          height: 1,
                          width: _width * 0.5,
                          color: kColorRed,
                        ),
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        Row(
                          textDirection: SharedValues.textDirection,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(texts[languages[language]]['nborder']),
                            SizedBox(
                              width: _width * 0.01,
                            ),
                            Text(SharedValues.cart.length.toString()),
                            SizedBox(
                              width: _width * 0.15,
                            ),
                            Text(texts[languages[language]]['total']),
                            SizedBox(
                              width: _width * 0.01,
                            ),
                            Text(
                                '${SharedValues.sumCart.toStringAsFixed(3)} \$'),
                          ],
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: _height * 0.02),
                            child: InkWell(
                              onTap: () {
                                if (SharedValues.cart.isNotEmpty)
                                  confirmationDialog();
                              },
                              child: Container(
                                height: _height * 0.07,
                                width: _width * 0.5,
                                child: Center(
                                  child: Text(
                                    texts[languages[language]]['request'],
                                    style: GoogleFonts.robotoSlab(
                                        color: Colors.white,
                                        fontSize: _height * 0.025,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    stops: [0, 1],
                                    colors: [
                                      kColorRed,
                                      kDarkText,
                                    ],
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(_width * 0.1),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }

  // doneDialog() {
  //   double _height = MediaQuery.of(context).size.height;
  //   double _width = MediaQuery.of(context).size.width;
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(builder: (context, setState) {
  //           return AlertDialog(
  //               backgroundColor: kDarkText,
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(32.0))),
  //               content: Container(
  //                   height: _height * 0.35,
  //                   width: _width * 0.5,
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Container(
  //                         height: 150,
  //                         width: 150,
  //                         decoration: BoxDecoration(
  //                             borderRadius: BorderRadius.circular(_width * 0.5),
  //                             border:
  //                                 Border.all(color: Colors.white70, width: 3)),
  //                         child: Icon(
  //                           Icons.done,
  //                           color: kColorRed,
  //                           size: 120,
  //                         ),
  //                       ),
  //                     ],
  //                   )));
  //         });
  //       });
  // }
  //

  confirmationDialog() {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
                backgroundColor: kDarkText,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                content: Container(
                    height: _height * 0.5,
                    width: _width * 0.5,
                    child: SingleChildScrollView(
                      child: Column(children: [
                        SizedBox(
                          height: _height * 0.01,
                        ),
                        ChampDuTextAuth(
                          onChanged: (value) {
                            setState(() {
                              phone = value;
                            });
                          },
                          textAlign: directions[language],
                          hintText: texts[languages[language]]['phone'],
                          icon: Icons.phone,
                          textInputType: TextInputType.number,
                        ),
                        SizedBox(
                          height: _height * 0.04,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(_width * 0.05),
                            color: Colors.black45,
                          ),
                          height: _height * 0.29,
                          width: _width * 0.6,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int i = 0; i < User.address.length; i++)
                                  addressContainer(Colors.black12,
                                      User.address[i], _height, _width, () {
                                    print(User.address[i]);

                                    setState(() {
                                      selected = i;
                                    });
                                  }, selected == i ? true : false),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.03,
                        ),
                        CustomButton(
                            colorInterieur: kColorRed,
                            text: texts[languages[language]]['ok'],
                            onTap: () async {
                              if (phone != null) {
                                setState(() {
                                  SharedValues.orders = [];
                                  SharedValues.sumCart = 0;
                                });
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SplashScreen()),
                                    (route) => false);
                                await CartController().confirmOrder(
                                    phone, User.address[selected]);
                              } else {
                                errorDialog(
                                    texts[languages[language]]['E-name'],
                                    context);
                              }
                            },
                            height: _height * 0.05,
                            width: _width * 0.3)
                      ]),
                    )));
          });
        });
  }

  Widget addressContainer(color, address, _height, _width, onTap, selected) {
    return InkWell(
      onTap: onTap,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: selected == true ? _height * 0.02 : _height * 0.026,
                  horizontal: _width * 0.02),
              child: Row(
                  textDirection: SharedValues.textDirection,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      address,
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white70,
                        fontSize: _height * 0.018,
                        fontWeight: kfontWeight,
                      ),
                    ),
                    selected == true
                        ? Icon(
                            Icons.check_circle_rounded,
                            color: Colors.white70,
                          )
                        : SizedBox()
                  ]),
            ),
            Center(
              child: Container(
                color: Colors.grey[300],
                height: 1,
                width: _width * 0.55,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
