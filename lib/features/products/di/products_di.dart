import 'package:get_it/get_it.dart';
import 'package:graduation/features/products/data/repository/products_repository_impl.dart';
import 'package:graduation/features/products/domain/repository/products_repository.dart';
import 'package:graduation/features/products/domain/use_cases/add_product_use_case.dart';
import 'package:graduation/features/products/domain/use_cases/get_products_use_case.dart';

final injector = GetIt.instance;

class ProductsDi {
  static Future<void> init() async {
    // usecases
    injector.registerFactory(() => GetProductsUseCase(injector()));
    injector.registerFactory(() => AddProductUseCase(injector()));
    // repository
    injector.registerLazySingleton<ProductsRepository>(() =>
        ProductsRepositoryImpl(
        ));
  }
}