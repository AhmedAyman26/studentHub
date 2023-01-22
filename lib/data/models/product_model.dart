class ProductModel {
  int? status;
  String? message;
  Product? product;

  ProductModel({required this.status, required this.message, required this.product});

  ProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  int? id;
  String? category;
  String? name;
  String? price;
  String? description;

  Product({required this.id, required this.category, required this.name, required this.price, required this.description});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['name'] = this.name;
    data['price'] = this.price;
    data['description'] = this.description;
    return data;
  }
}
