import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:graduation/features/products/presentation/pages/products_page/products_state.dart';
import 'package:graduation/shared/utils.dart';

class ProductsCubit extends Cubit<ProductsState>
{
  late final GetProductsUseCase _getProductsUseCase;
  ProductsCubit():super(const ProductsState())
  {
    _loadInjector();
  }

  _loadInjector()
  {
    _getProductsUseCase=injector();
  }

  static ProductsCubit get(context)=>BlocProvider.of(context);
  void getProducts(String category)async
  {
    emit(state.copyWith(productState: RequestStatus.loading));
    try
    {
      final products=await _getProductsUseCase.call(category);
      emit(state.copyWith(productState: RequestStatus.success,products: products));
    }
    catch(error)
    {
      emit(state.copyWith(errorMessage: error.toString(),productState: RequestStatus.error));
    }
  }
}