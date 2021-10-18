import 'package:sayertti/controleurs/Helpers/Config.dart';
import 'package:sayertti/controleurs/Helpers/HttpClient.dart';
import 'package:sayertti/models/product.dart';
import 'package:sayertti/models/user.dart';

import 'Helpers/sharedValues.dart';
import 'Helpers/tokensHelper.dart';

class CartController {
  HttpClient _httpClient = HttpClient();

  getCart() async {
    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };
    var response =
        await _httpClient.getRequest(Urls.carts + '/${User.cartId}', headers);

    if (response['status'] == true) {
      var cart = response['body']['items'] as List;
      SharedValues.cart =
          cart.map<Product>((product) => Product.fromJson(product)).toList();
      for (Product product in SharedValues.cart) {
        SharedValues.sumCart +=
            product.productQuantity * double.parse(product.productPrice);
      }
    }
  }

  addToCart(Product product) async {
    print('${Urls.carts}/${User.cartId}');
    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };
    var body = {"id": product.productId, "quantity": product.productQuantity};

    var response = await _httpClient.putRequest(
        '${Urls.carts}/${User.cartId}', headers, body);
    if (response["status"] == true) {
      SharedValues.cart.add(product);
      if(product.productPromotion == '0')
      SharedValues.sumCart = SharedValues.sumCart +
          (double.parse(product.productPrice) * product.productQuantity);
      else
      SharedValues.sumCart = SharedValues.sumCart +
          (product.productPromotedPrice * product.productQuantity);

    }
  }

  deleteFromCart(Product product) async {
    print('${Urls.carts}/${User.cartId}');
    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };
    var body = {"id": product.productId, "quantity": 0};

    var response = await _httpClient.putRequest(
        '${Urls.carts}/${User.cartId}', headers, body);
    if (response["status"] == true) {
      SharedValues.cart.remove(product);
      SharedValues.sumCart = SharedValues.sumCart -
          (double.parse(product.productPrice) * product.productQuantity);
    }
  }

  confirmOrder(phone,address) async {
    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };
    var body = {"phoneNumber": phone, "address": address};
    var response = 
    await _httpClient.postRequest(
        Urls.confirmCarts + '/${User.cartId}', headers,body);

     print(response);
  }
}
