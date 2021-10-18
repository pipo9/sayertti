
class Product {

  String productId;
  String productNameFr;
  String productNameAr;
  String productDescriptionFr;
  String productDescriptionAr;
  String productPrice;
  String productImageUrl;
  int productQuantity;
  String productCategory;
  String productPromotion;
  String productSearchingText;
  double productPromotedPrice;

  Product(this.productId,
      this.productNameFr,
      this.productNameAr,
      this.productDescriptionFr,
      this.productDescriptionAr,
      this.productPrice,
      this.productImageUrl,
      this.productQuantity,
      this.productCategory,
      this.productPromotion,
      this.productPromotedPrice,
      this.productSearchingText) ;


  factory Product.fromJson(Map<String, dynamic> product) {


    return Product(
        product["id"],
        product['title'],
        product['titleAr'],
        product['description'],
        product['descriptionAr'],
        product['price'],
        product['thumbnail'],
        product['quantity']!=null?product['quantity']:1,
        product['category'],
        product['promotion'],
        double.tryParse(product['price'])*(1.0 - double.tryParse('0'+product['promotion'])),
        product['category']+product['title']+product['titleAr']
        );
  }

    static Map<String,dynamic> toJson(Product product){
    return {
      "id": product.productId,
      "title": product.productNameFr,
      "titleAr": product.productNameAr,
      "description": product.productDescriptionFr,
      "descriptionAr": product.productDescriptionAr,
      "price": product.productPrice,
      "keywords": [
        "Bio",
        "Fresh",
        "Fruit"
      ],
      "thumbnail": product.productImageUrl,
      "availableQuantity": "20",
      "category": product.productCategory,
      "quantity": product.productQuantity,
      "promotion":product.productPromotion
    };
  }
}
