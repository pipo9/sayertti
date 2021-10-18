import 'package:sayertti/controleurs/Helpers/HttpClient.dart';
import 'package:sayertti/models/order.dart';
import 'Helpers/Config.dart';
import 'Helpers/sharedValues.dart';
import 'Helpers/tokensHelper.dart';

class OrderController {
  HttpClient _httpClient = HttpClient();

  getOrders() async {
    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };
    var response = await _httpClient.getRequest(Urls.orders, headers);
    if (response['status'] == true) {
      var orders = response['body']['orders'] as List;
      var id, status;
      List<dynamic> items;
      dynamic price;
      // print(orders);
      // SharedValues.orders = orders
      //     .map<Order>((order) => Order.fromJson(order))
      //     .toList();
      for (int i = 0; i < orders.length; i++) {
       // print("Order Body $i: ${response['body']['orders'][i]['items']}");
       // print("Order Body $i: ${response['body']['orders'][i]['id']}");
       // print("Order Body $i: ${response['body']['orders'][i]['orderStatus']}");

        id=orders[i]['id'];
        status=orders[i]['orderStatus'];
        items=orders[i]['items'];
        price=orders[i]['totalPrice'];

        SharedValues.orders.add(Order.fromJson(items,id,status,price));
      }
    }
  }
}
