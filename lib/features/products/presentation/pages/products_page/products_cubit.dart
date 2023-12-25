import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/chats/data/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/use_cases/send_msessage_use_case.dart';
import 'package:graduation/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:graduation/features/products/presentation/pages/products_page/products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  late final GetProductsUseCase _getProductsUseCase;
  late final SendMessageUseCase _sendMessageUseCase;

  ProductsCubit() : super(const ProductsState()) {
    _loadInjector();
  }

  _loadInjector() {
    _getProductsUseCase = injector();
    _sendMessageUseCase = injector();
  }

  static ProductsCubit get(context) => BlocProvider.of(context);

  void getProducts(String category) async {
    emit(state.copyWith(getProductState: RequestStatus.loading));
    try {
      final products = await _getProductsUseCase.call(category);
      emit(state.copyWith(
          getProductState: RequestStatus.success, products: products));
    } catch (error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          getProductState: RequestStatus.error));
    }
  }

  void requestProduct(ApiMessageModel message) async {
    try {
      emit(state.copyWith(requestProductState: RequestStatus.loading));
      await _sendMessageUseCase.call(message);
      emit(state.copyWith(requestProductState: RequestStatus.success));
    } catch (error) {
      emit(state.copyWith(
          getProductState: RequestStatus.error,
          errorMessage: error.toString()));
    }
  }
}
