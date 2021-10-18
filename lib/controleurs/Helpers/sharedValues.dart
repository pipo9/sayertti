
import 'dart:ui';

import 'package:sayertti/models/category.dart';
import 'package:sayertti/models/order.dart';
import 'package:sayertti/models/product.dart';

class SharedValues{
  static int indexProduct=0;
  static double sumCart=0;
  static List<Product> products=[];
  static List<Category> categories=[];
  static List<Product> cart=[];
  static List<Order> orders=[];
  static String userAddress='';
  static String resetPasswordCode='';
  static List<String> messages=[];
  static TextDirection textDirection=TextDirection.ltr;
}