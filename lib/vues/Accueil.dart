import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/controleurs/productController.dart';
import 'package:sayertti/controleurs/userController.dart';
import 'package:sayertti/language.dart';
import 'package:sayertti/models/category.dart';
import 'package:sayertti/vues/support.dart';
import 'cart.dart';
import 'package:sayertti/constants.dart';
import 'package:sayertti/vues/Order.dart';
import 'package:sayertti/vues/parametres.dart';
import 'package:sayertti/vues/product.dart';
import 'package:sayertti/vues/profile.dart';

class Accueil extends StatefulWidget {
  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  UserController userController=UserController();
  final searchTextController = TextEditingController();

  final texts = toMap(); // les donnees en format MAP
  double cursor = 0.0;
  int counter=0;
  String search='';
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xffF8F8F8),
        appBar: kHomeAppBar(
            language,
            () async{
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            _width,
            searchTextController,
            (value){
              setState(() {
                search=value;
              });
            },
            ()  {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Support()));
            }
            ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: language == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    reverse: false,
                    child: Row(
                      textDirection:
                          SharedValues.textDirection,
                      children: [
                        category(new Category('0', texts[languages[0]]['all'],texts[languages[1]]['all']),0),
                        for(int i=1;i< SharedValues.categories.length;i++)
                           category(SharedValues.categories[i-1],i)

                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: language == 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: Container(
                    margin: language == 0
                        ? EdgeInsets.only(left: _width * cursor)
                        : EdgeInsets.only(right: _width * cursor),
                    height: _height * 0.002,
                    width: _width * 0.16,
                    color: Color(0xffE61010),
                  ),
                ),
                Wrap(
                  spacing: _width * 0.08,
                  children: [
                    for(var prod in ProductController().searchProduct(search))
                         product(language==0?prod.productNameFr:prod.productNameAr,prod.productImageUrl, prod.productPrice.toString(), () {
                           SharedValues.indexProduct=SharedValues.products.indexOf(prod);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ProductDetails()));
                    }),]

                ),
                SizedBox(
                  height: _height * 0.05,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            height: _height * 0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  iconSize: 30.0,
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Cart()));
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  icon: Icon(Icons.shopping_bag),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Order()));
                  },
                ),
                IconButton(
                  iconSize: 30.0,
                  padding: EdgeInsets.only(right: _width * 0.05),
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Settings()));
                  },
                ),
              ],
            ),
          ),
        ));
  }

  //category component
  Widget category(Category category, int place) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    String catName=language==0 ? category.nameFr : category.nameAr;
    double fontSize= _height * 0.02 ;
    double containerWidth = 0.16 ;

    return InkWell(
      onTap:() {
    searchTextController.clear();
    setState(() {
      if(category.nameFr=="Tous" || category.nameAr=="الكل" )
          search = '';
      else
          search = category.nameFr;
    cursor = containerWidth * place;
    });
    },
      child: Container(
        height: _height * 0.06,
        width: _width * containerWidth,
        child: Center(
          child: Text(
            catName,
            style: GoogleFonts.robotoSlab(
                fontSize: fontSize, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }


  //product component
  Widget product(String name,String image, String price, onTap) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(top: _height * 0.02),
      width: _width * 0.4,
      height: _height * 0.27,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_width * 0.05),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.15),
                spreadRadius: 0.1,
                blurRadius: 5,
                offset: Offset(0, 5))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: _height * 0.03),
            width: _width * 0.3,
            height: _height * 0.1,
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: language==0 ? Alignment.centerLeft : Alignment.centerRight,
            child: Padding(
              padding:
                  EdgeInsets.only(top: _height * 0.02, left: _width * 0.02,right: _width * 0.02),
              child: Text(
              
                name,
                style: GoogleFonts.robotoSlab(
                    color: Color(0xffE61010),
                    fontSize: _height * 0.025,
                    fontWeight: FontWeight.bold),
                    
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(
                    top: _height * 0.02,
                    left: _width * 0.03,
                    right: _width * 0.05),
                child: Row(
                  textDirection:
                  SharedValues.textDirection,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.robotoSlab(
                          color: Colors.black,
                          fontSize: _height * 0.025,
                          fontWeight: FontWeight.bold),
                    ),
                    InkWell(
                        onTap: onTap,
                        child: Container(
                          height: _height * 0.04,
                          width: _width * 0.065,
                          decoration: BoxDecoration(
                              color: Color(0xffE61010),
                              borderRadius:
                                  BorderRadius.circular(_width * 0.1)),
                          child: Center(
                            child: Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: _width * 0.045,
                            ),
                          ),
                        ))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
