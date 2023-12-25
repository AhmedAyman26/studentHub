class ProductModel {
  final String? name;
  final String? price;
  final String? description;
  final String? image;
  final String? studentName;
  final String? studentImage;
  final String? firebaseId;

  ProductModel(
      {
      required this.name,
      required this.price,
      required this.description,
      required this.image,
      required this.studentName,
      this.studentImage,required this.firebaseId});

  ProductModel.initial()
      : this(
            price: '',
            image: '',
            description: '',
            studentName: '',
            name: '',
            studentImage: '',firebaseId: '');
}
