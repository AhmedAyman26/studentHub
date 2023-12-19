import 'package:graduation/features/products/domain/models/product_model.dart';
import 'package:graduation/features/products/domain/repository/products_repository.dart';

class GetProductsUseCase
{
  final ProductsRepository _productsRepository;

  GetProductsUseCase(this._productsRepository);

  Future<List<ProductModel>> call(String category)async
  {
    return await _productsRepository.getProducts(category);
  }
}