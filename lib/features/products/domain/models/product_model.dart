class ProductModel {
  final String? id;
  final String? name;
  final double? price;
  final String? description;
  final String? image;
  final String? studentName;
  final String? studentImage;

  ProductModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.studentName,
      this.studentImage});
}
