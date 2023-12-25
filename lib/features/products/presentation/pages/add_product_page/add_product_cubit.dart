import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/products/domain/models/inputs/add_product_input.dart';
import 'package:graduation/features/products/domain/use_cases/add_product_use_case.dart';
import 'package:graduation/features/products/presentation/pages/add_product_page/add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  final AddProductUseCase _addProductUseCase;
  AddProductCubit(this._addProductUseCase) : super(AddProductState());

  static AddProductCubit get(context)=>BlocProvider.of(context);

  void addProduct(AddProductInput input)async
  {
    emit(state.copyWith(addProductState: RequestStatus.loading));
    try {
      final message = await _addProductUseCase.call(input);
      emit(state.copyWith(
          addProductState: RequestStatus.success, message: message));
    }
    catch(error)
    {
      emit(state.copyWith(message: error.toString(),addProductState: RequestStatus.error));
    }
  }
}
