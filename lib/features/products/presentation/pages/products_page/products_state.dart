import 'package:equatable/equatable.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/products/domain/models/product_model.dart';

class ProductsState extends Equatable
{
  final String? errorMessage;
  final List<ProductModel>? products;
  final RequestStatus? getProductState;
  final RequestStatus? requestProductState;

  const ProductsState({this.errorMessage='', this.products=const[], this.getProductState=RequestStatus.initial,this.requestProductState=RequestStatus.initial});

  ProductsState copyWith({
    String? errorMessage,
    List<ProductModel>? products,
    RequestStatus? getProductState,
    RequestStatus? requestProductState

  })
  {
    return ProductsState(errorMessage: errorMessage??this.errorMessage,products: products??this.products,getProductState: getProductState??this.getProductState,requestProductState: requestProductState??this.requestProductState);
  }

  @override
  List<Object?> get props => [errorMessage,products,getProductState,requestProductState];
}