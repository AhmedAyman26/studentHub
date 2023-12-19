import 'package:graduation/features/products/domain/models/inputs/add_product_input.dart';
import 'package:graduation/features/products/domain/models/product_model.dart';

abstract class ProductsRepository
{
  Future<List<ProductModel>> getProducts(String category);
  Future<String> addProduct(AddProductInput input);
}