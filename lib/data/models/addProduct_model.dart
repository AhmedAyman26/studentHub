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
required this.productId,
required this.productName,
required this.productImage,
required this.productDesc,
required this.price,
});
late final String productId;
late final String productName;
late final String productImage;
late final String productDesc;
late final String price;

Product.fromJson(Map<String, dynamic> json){
productId = json['product_id'];
productName = json['product_name'];
productImage = json['product_image'];
productDesc = json['product_desc'];
price = json['price'];
}

}