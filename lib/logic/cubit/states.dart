import '../../data/models/addProduct_model.dart';
import '../../data/models/getProduct_model.dart';


abstract class GraduationStates{}

class GraduationInitialState extends GraduationStates{}

class GetUserDataLoadingState extends GraduationStates{}

class GetUserDataSuccessState extends GraduationStates{}

class GetUserDataErrorState extends GraduationStates{}

class ChangeSelectedItemState extends GraduationStates{}

class AddProductLoadingState extends GraduationStates{}

class AddProductSuccessState extends GraduationStates{
  AddProductModel addProductModel;
  AddProductSuccessState(this.addProductModel);
}

class AddProductErrorState extends GraduationStates{
  final String error;
  AddProductErrorState(this.error);
}

class GetProductLoadingState extends GraduationStates{}

class GetProductSuccessState extends GraduationStates{
  GetProductModel getProductModel;
  GetProductSuccessState(this.getProductModel);
}

class GetProductErrorState extends GraduationStates{
final String error;
GetProductErrorState(this.error);
}
class GetUsersSuccessState extends GraduationStates{}

class GetUsersErrorState extends GraduationStates{}

class SendMessageSuccessState extends GraduationStates{}

class SendMessageErrorState extends GraduationStates{}

class GetMessagesLoadingState extends GraduationStates{}

class GetMessagesSuccessState extends GraduationStates{}

