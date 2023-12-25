class AddProductInput
{
  final String? productName;
  final String? productImage;
  final String? productDescription;
  final String? studentId;
  final String? categoryId;
  final String? price;
  final String? firebaseId;

  AddProductInput({this.productName, this.productImage, this.productDescription, this.studentId, this.categoryId, this.price,this.firebaseId,});

  static Map<String,dynamic> toJson(AddProductInput input)
  {
    return
      {
        "product_name":input.productName,
        "product_image":input.productImage,
        "product_desc":input.productDescription,
        "student_id":input.studentId,
        "category_id":input.categoryId,
        "price":input.price,
        "firebase_id":input.firebaseId
      };
  }
}