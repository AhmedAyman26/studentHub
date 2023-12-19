import 'package:graduation/features/products/domain/models/inputs/add_product_input.dart';
import 'package:graduation/features/products/domain/repository/products_repository.dart';

class AddProductUseCase
{
  final ProductsRepository _productsRepository;

  AddProductUseCase(this._productsRepository);

  Future<String> call(AddProductInput input)async
  {
    return await _productsRepository.addProduct(input);
  }
}