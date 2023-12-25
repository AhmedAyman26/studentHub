import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';

class LoginState extends Equatable
{
  final RequestStatus loginState;
  final String errorMessage;
  final UserData userData;

  const LoginState({this.loginState=RequestStatus.initial, this.errorMessage='',this.userData=const UserData.initial(),});

  LoginState copyWith({RequestStatus? loginState,String? errorMessage,UserData? userData,
  })
  {
    return LoginState(loginState: loginState??this.loginState, errorMessage: errorMessage??this.errorMessage,userData: userData??this.userData);
  }

  @override
  List<Object?> get props => [loginState,errorMessage,userData];
}