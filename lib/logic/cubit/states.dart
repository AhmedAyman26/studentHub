import 'package:graduation/data/models/ServiceModel.dart';

import '../../data/models/addProduct_model.dart';


abstract class GraduationStates{}


class GraduationInitialState extends GraduationStates{}

class GetUserDataLoadingState extends GraduationStates{}

class GetUserDataSuccessState extends GraduationStates{}

class GetUserDataErrorState extends GraduationStates{}

class ChangeSelectedItemState extends GraduationStates{}

class ChangeSelectedSubject extends GraduationStates{}

class AddProductLoadingState extends GraduationStates{}

class AddProductSuccessState extends GraduationStates{
  AddProductModel addProductModel;
  AddProductSuccessState(this.addProductModel);
}

class AddProductErrorState extends GraduationStates{
  final String error;
  AddProductErrorState(this.error);
}

class GetUsersSuccessState extends GraduationStates{}

class GetUsersErrorState extends GraduationStates{}

class SendMessageSuccessState extends GraduationStates{}

class SendMessageErrorState extends GraduationStates{}

class GetMessagesLoadingState extends GraduationStates{}

class GetMessagesSuccessState extends GraduationStates{}

class AddServiceImageSuccessState extends GraduationStates{}

class AddServiceImageErrorState extends GraduationStates{}

class AddVideoLoadingState extends GraduationStates{}


class AddVideoSuccessState extends GraduationStates{}

class AddVideoErrorState extends GraduationStates{
  AddVideoErrorState(String error);
}
class AddServiceLoadingState extends GraduationStates{}

class AddServiceSuccessState extends GraduationStates{
  // ServiceModel serviceModel;
  AddServiceSuccessState();
}

class AddServiceErrorState extends GraduationStates{
  AddServiceErrorState(String string);
}



class PostImageSuccessStates extends GraduationStates{}

class PostImageErrorStates extends GraduationStates{}



