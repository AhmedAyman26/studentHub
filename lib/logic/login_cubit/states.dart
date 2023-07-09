import 'package:graduation/data/models/user_model.dart';

abstract class LoginStates{}

class LoginInitialState extends LoginStates{}

class LoginLoadingState extends LoginStates{}

class LoginSuccessState extends LoginStates{
  final String uId;
  final UserData userData;
  LoginSuccessState(this.uId, this.userData);
}

class LoginErrorState extends LoginStates{
  final String error;
  LoginErrorState(this.error);
}
class ChangePasswordVisibilityState extends LoginStates{}
