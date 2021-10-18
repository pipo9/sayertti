


import 'package:sayertti/controleurs/Helpers/Config.dart';
import 'package:sayertti/controleurs/Helpers/HttpClient.dart';
import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/controleurs/cartController.dart';
import 'package:sayertti/controleurs/orderController.dart';
import 'package:sayertti/controleurs/productController.dart';
import 'package:sayertti/models/category.dart';

import 'Helpers/tokensHelper.dart';

class Controller{
  HttpClient _httpClient = HttpClient();

  initialiseConfig() async{
    await ProductController().getAllProducts();
    await CartController().getCart();
    await OrderController().getOrders();

    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };
    var response= await _httpClient.getRequest(Urls.categories, headers);
    if (response['status'] == true) {
      var preCategories = response['body']['categories'] as List;

      SharedValues.categories = preCategories
          .map<Category>((category) => Category.fromJson(category))
          .toList();
    }
}

}