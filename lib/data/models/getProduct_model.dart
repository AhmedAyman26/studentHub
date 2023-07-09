class GetProductModel {
  GetProductModel({
    required this.products,
    required this.success,
    required this.message,
  });
  late final List<Products> products;
  late final bool success;
  late final String message;

  GetProductModel.fromJson(Map<String, dynamic> json){
    products = List.from(json['products']).map((e)=>Products.fromJson(e)).toList();
    success = json['success'];
    message = json['message'];
  }
}

class Products {
  Products({
    required this.fullname,
    required this.productName,
    required this.productImage,
    required this.productDesc,
    required this.price,
    required this.firebase_id
  });
  late final String fullname;
  late final String productName;
  late final String productImage;
  late final String productDesc;
  late final String price;
  late final firebase_id;

  Products.fromJson(Map<String, dynamic> json){
    fullname = json['fullname'];
    productName = json['product_name'];
    productImage = json['product_image'];
    productDesc = json['product_desc'];
    price = json['price'];
    firebase_id=json['firebase_id'];
  }

}