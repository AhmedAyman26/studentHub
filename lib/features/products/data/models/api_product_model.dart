class ApiProductModel {
  final List<ApiProduct>? products;
  final bool? success;
  final String? message;

  ApiProductModel({
    this.products,
    this.success,
    this.message,
  });

  factory ApiProductModel.fromJson(Map<String, dynamic> json) => ApiProductModel(
    products: json["products"] == null ? [] : List<ApiProduct>.from(json["products"]!.map((x) => ApiProduct.fromJson(x))),
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "success": success,
    "message": message,
  };
}

class ApiProduct {
  final String? fullname;
  final int? productId;
  final String? productName;
  final String? productImage;
  final String? productDesc;
  final String? price;
  final String? image;
  final String? firebaseId;

  ApiProduct({
    this.fullname,
    this.productId,
    this.productName,
    this.productImage,
    this.productDesc,
    this.price,
    this.image,
    this.firebaseId
  });

  factory ApiProduct.fromJson(Map<String, dynamic> json) => ApiProduct(
    fullname: json["fullname"],
    productId: json["product_id"],
    productName: json["product_name"],
    productImage: json["product_image"],
    productDesc: json["product_desc"],
    price: json["price"],
    image: json["image"],
    firebaseId: json['firebase_id'],
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "product_id": productId,
    "product_name": productName,
    "product_image": productImage,
    "product_desc": productDesc,
    "price": price,
    "image": image,
    "firebase_id":firebaseId,
  };
}
