import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/controleurs/cartController.dart';
import 'package:sayertti/models/product.dart';
import 'cart.dart';
import '../language.dart';
import '../constants.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final texts = toMap();
  //variable pour afficher la cercle qui tourne en temps de chargement
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Product product = SharedValues.products[SharedValues.indexProduct];
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xffF8F8F8),
      appBar: kAppBar(() => Navigator.pop(context), _width * 1.1, _height,
          texts[languages[language]]['details']),
      body: ModalProgressHUD(
        inAsyncCall: loading,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          
            Align(
              alignment: Alignment.center,
              child: Container(
                height: _height * 0.33,
                width: _width,
                child: Image.network(
                  product.productImageUrl,
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(_width * 0.07),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 0.1,
                          blurRadius: 5,
                          offset: Offset(0, 5))
                    ]),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _height * 0.05,
                  bottom: _height * 0.03,
                  left: _width * 0.07,
                  right: _width * 0.07),
              child: Row(
                textDirection: SharedValues.textDirection,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    language == 0
                        ? product.productNameFr
                        : product.productNameAr,
                    style: GoogleFonts.robotoSlab(
                        color: Colors.black,
                        fontSize: _height * 0.04,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),
                  
                      product.productPromotion == '0'? Text(
                          "${product.productPrice} \$",
                          style: GoogleFonts.robotoSlab(
                              color: Colors.black,
                              fontSize: _height * 0.028,
                              fontWeight: FontWeight.bold),
                        )
                      : promotedPrice(product),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: _height * 0.03,
                  left: _width * 0.09,
                  right: _width * 0.09),
              child: Column(
                textDirection: SharedValues.textDirection,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: language == 0
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: Text(
                        texts[languages[language]]["details"] + '\n',
                        style: GoogleFonts.robotoSlab(
                            color: Colors.black,
                            fontSize: _height * 0.025,
                            fontWeight: FontWeight.bold),
                        textDirection: SharedValues.textDirection,
                      )),
                  Align(
                      alignment: language == 0
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: Text(
                        language == 0
                            ? product.productDescriptionFr
                            : product.productDescriptionAr,
                        style: GoogleFonts.robotoSlab(
                            color: Colors.black,
                            fontSize: _height * 0.018,
                            fontWeight: FontWeight.bold),
                        textDirection: SharedValues.textDirection,
                      ))
                ],
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: _width * 0.07),
                child: Row(
                  textDirection: SharedValues.textDirection,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      textDirection: SharedValues.textDirection,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: _width * 0.03),
                          child: Icon(
                            Icons.library_books_rounded,
                            size: _width * 0.06,
                          ),
                        ),
                        Text(
                          texts[languages[language]]['nbr'],
                          style: GoogleFonts.robotoSlab(
                              color: Colors.black,
                              fontSize: _height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      width: _width * 0.3,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: _height * 0.006,
                            horizontal: _width * 0.03),
                        child: Row(
                          textDirection: SharedValues.textDirection,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  if (product.productQuantity > 1)
                                    product.productQuantity--;
                                });
                              },
                              child: Container(
                                height: _height * 0.03,
                                width: _width * 0.05,
                                child: Center(
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _height * 0.025,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(_width * 0.1),
                                    color: kColorRed),
                              ),
                            ),
                            Text(
                              '${product.productQuantity}',
                              style: GoogleFonts.robotoSlab(
                                  color: Colors.black,
                                  fontSize: _height * 0.03,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  product.productQuantity++;
                                });
                              },
                              child: Container(
                                height: _height * 0.03,
                                width: _width * 0.05,
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: _height * 0.025,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(_width * 0.1),
                                    color: kColorRed),
                              ),
                            )
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(_width * 0.1),
                          border: Border.all(color: kColorRed)),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: _height * 0.1),
                child: InkWell(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });
                    await new CartController().addToCart(
                        SharedValues.products[SharedValues.indexProduct]);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                    setState(() {
                      loading = false;
                    });
                  },
                  child: Container(
                    height: _height * 0.07,
                    width: _width * 0.5,
                    child: Row(
                      textDirection: SharedValues.textDirection,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          texts[languages[language]]['add'],
                          style: GoogleFonts.robotoSlab(
                              color: Colors.white,
                              fontSize: _height * 0.025,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: _width * 0.03,
                        ),
                        Icon(
                          Icons.shopping_cart,
                          color: Colors.white,
                          size: _width * 0.05,
                        )
                      ],
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
                      borderRadius: BorderRadius.circular(_width * 0.1),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }

  promotedPrice(Product product) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Row(
      textDirection: SharedValues.textDirection,
      children: [
        Text(
          "${product.productPromotedPrice} \$",
          style: GoogleFonts.robotoSlab(
              color: Color(0xffE61010),
              fontSize: _height * 0.025,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(width: _width*0.03,),
        Text(
          "${product.productPrice} \$",
          style: GoogleFonts.robotoSlab(
              decorationColor: Colors.red,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.lineThrough,
              color: Colors.black,
              fontSize: _height * 0.025,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
