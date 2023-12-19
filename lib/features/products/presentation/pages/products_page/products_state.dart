import 'package:equatable/equatable.dart';
import 'package:graduation/features/products/domain/models/product_model.dart';
import 'package:graduation/shared/utils.dart';

class ProductsState extends Equatable
{
  final String? errorMessage;
  final List<ProductModel>? products;
  final RequestStatus? productState;

  const ProductsState({this.errorMessage='', this.products=const[], this.productState=RequestStatus.initial});

  ProductsState copyWith({
    String? errorMessage,
    List<ProductModel>? products,
    RequestStatus? productState
})
  {
    return ProductsState(errorMessage: errorMessage??this.errorMessage,products: products??this.products,productState: productState??this.productState);
  }

  @override
  List<Object?> get props => [errorMessage,products,productState];
}