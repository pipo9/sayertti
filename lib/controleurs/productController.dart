import 'package:sayertti/controleurs/Helpers/sharedValues.dart';
import 'package:sayertti/controleurs/Helpers/tokensHelper.dart';
import 'package:sayertti/models/product.dart';
import 'Helpers/Config.dart';
import 'Helpers/HttpClient.dart';

class ProductController {
  HttpClient _httpClient = HttpClient();

  getAllProducts() async {
    final tokens = await TokenHelper.getLocalTokens();
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${tokens['accessToken']}'
    };

    var response = await _httpClient.getRequest(Urls.products, headers);

    if (response['status'] == true) {
      var preProducts = response['body']['products'] as List;

      SharedValues.products = preProducts
          .map<Product>((product) => Product.fromJson(product))
          .toList();
    }
  }

  List<Product> searchProduct(String search) {
     List<Product> searchResultProducts=[];

    for (Product product in SharedValues.products) {
      if (product.productSearchingText.contains(search) ) {
       searchResultProducts.add(product);
      }
    }
    return searchResultProducts;
  }
}
