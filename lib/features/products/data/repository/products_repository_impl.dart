import 'dart:convert';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/features/products/data/mappers/api_product_mapper.dart';
import 'package:graduation/features/products/data/models/api_product_model.dart';
import 'package:graduation/features/products/domain/models/inputs/add_product_input.dart';
import 'package:graduation/features/products/domain/models/product_model.dart';
import 'package:graduation/features/products/domain/repository/products_repository.dart';

class ProductsRepositoryImpl extends ProductsRepository {
  @override
  Future<List<ProductModel>> getProducts(String category) async {
    final request = await DioHelper.getData(
        url: 'getprod.php', query: {"category": category});
    if(request.statusCode!=200)
    {
      throw Exception(request.statusMessage);
    }else
    {
      final result=ApiProductModel.fromJson(jsonDecode(request.data)).products;
      return result?.map((e) => e.map()).toList()??[];
    }
  }

  @override
  Future<String> addProduct(AddProductInput input)async {
    final request = await DioHelper.postData(
        url: 'product.php',data: AddProductInput.toJson(input));
    if(request.statusCode!=201)
    {
      throw Exception(request.statusMessage);
    }else
    {
      final result=jsonDecode(request.data)['message'];
      return result;
    }
  }
}
