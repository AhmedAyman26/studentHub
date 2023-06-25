class AddProductModel {
AddProductModel({
  required this.product,
  required this.success,
  required this.message,
});
late final Product product;
late final bool success;
late final String message;

AddProductModel.fromJson(Map<String, dynamic> json){
product = Product.fromJson(json['product']);
success = json['success'];
message = json['message'];
}

}

class Product {
Product({
  required this.category_id,
  required this.student_id,
required this.productId,
required this.productName,
required this.productImage,
required this.productDesc,
required this.price,
});
int? category_id;
late final String productId;
late final String productName;
late final String productImage;
late final String productDesc;
late final String price;
late final String student_id;

Product.fromJson(Map<String, dynamic> json){
category_id=json['category_id'];
student_id=json['student_id'];
productId = json['product_id'];
productName = json['product_name'];
productImage = json['product_image'];
productDesc = json['product_desc'];
price = json['price'];
}

}