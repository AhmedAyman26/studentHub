import 'package:equatable/equatable.dart';
import 'package:graduation/common/utils.dart';

class LoginState extends Equatable
{
  final RequestStatus loginState;
  final String errorMessage;

  const LoginState({this.loginState=RequestStatus.initial, this.errorMessage=''});

  LoginState copyWith({RequestStatus? loginState,String? errorMessage})
  {
    return LoginState(loginState: loginState??this.loginState, errorMessage: errorMessage??this.errorMessage);
  }

  @override
  List<Object?> get props => [loginState,errorMessage];
}