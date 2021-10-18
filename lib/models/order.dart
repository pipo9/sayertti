

import 'package:sayertti/models/product.dart';

class Order {
  String orderId;
  int orderStatus;
  List<Product> orderItems;
  dynamic orderProductsContainerHeight=0.0;
  dynamic orderPrice;

  Order(
      this.orderId,
      this.orderStatus,
      this.orderItems,
      this.orderPrice
      );

 static Order fromJson( orderItems, orderId , orderStatus , orderPrice ){
    List<Product> items=[];
    for(int i=0;i<orderItems.length;i++){
      print("product Body $i : ${orderItems[i]}");
      items.add(Product.fromJson(orderItems[i]));
    }
    return Order(orderId, orderStatus, items , orderPrice);
  }
}