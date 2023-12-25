import 'package:graduation/common/utils.dart';

class AddProductState {
  final RequestStatus addProductState;
  final String message;

  AddProductState(
      {this.addProductState = RequestStatus.initial, this.message = ''});

  AddProductState copyWith({RequestStatus? addProductState, String? message}) {
    return AddProductState(
        addProductState: addProductState ?? this.addProductState,
        message: message ?? this.message);
  }
}
