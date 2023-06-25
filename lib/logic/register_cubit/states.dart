import 'package:graduation/data/models/user_model.dart';

abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates{}

class RegisterDbLoadingState extends RegisterStates{}

class RegisterDbSuccessState extends RegisterStates{
  final UserData userData;

  RegisterDbSuccessState(this.userData);
}

class RegisterDbErrorState extends RegisterStates{
  final String error;
  RegisterDbErrorState(this.error);

}

class RegisterFbLoadingState extends RegisterStates{}

class RegisterFbSuccessState extends RegisterStates{

}

class RegisterFbErrorState extends RegisterStates{
  final String error;
  RegisterFbErrorState(this.error);

}

class CreateUserFbLoadingState extends RegisterStates{}

class CreateUserFbSuccessState extends RegisterStates{

}

class CreateUserFbErrorState extends RegisterStates{
  final String error;
  CreateUserFbErrorState(this.error);

}

class RegisterChangePasswordVisibilityState extends RegisterStates{}

// import 'package:graduation/data/models/user_model.dart';
//
//
// abstract class RegisterStates {}
//
// class RegisterInitialState extends RegisterStates{}
//
// class RegisterLoadingState extends RegisterStates{}
//
// class RegisterSuccessState extends RegisterStates{
//   final RegisterModel registerModel;
//   RegisterSuccessState(this.registerModel);
// }
//
// class RegisterErrorState extends RegisterStates{
//   final String error;
//   RegisterErrorState(this.error);
// }
//
// class PasswordVisibilityState extends RegisterStates{}
