import 'package:graduation/features/products/data/models/api_product_model.dart';
import 'package:graduation/features/products/domain/models/product_model.dart';

extension ApiProductMapper on ApiProduct {
  ProductModel map() {
    return ProductModel(
        name: productName ?? '',
        studentName: fullname ?? '',
        studentImage: image ?? '',
        image: productImage ?? '',
        description: productDesc ?? '',
        price: price ?? '',
      firebaseId: firebaseId??''
    );
  }
}
