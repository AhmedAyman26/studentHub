class ProductModel {
  String? id;
  String? category;
  String? name;
  double? price;
  String? description;
  String? image;
  String? studentId;

  ProductModel({required this.id, required this.category, required this.name, required this.price, required this.description,required this.image,required this.studentId});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    name = json['name'];
    price = json['price'];
    description = json['description'];
    image=json['image'];
    studentId=json['studentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> product = new Map<String, dynamic>();
    product['id'] = this.id;
    product['category'] = this.category;
    product['name'] = this.name;
    product['price'] = this.price;
    product['description'] = this.description;
    product['image']=this.image;
    product['studentId']=this.studentId;
    return product;
  }
}
