import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/authentication/domain/models/inputs/login_input.dart';
import 'package:graduation/features/authentication/domain/use_cases/login_use_case.dart';
import 'package:graduation/features/authentication/presentation/pages/login_page/login_state.dart';

class LoginCubit extends Cubit<LoginState>
{
  static LoginCubit get(context)=>BlocProvider.of(context);
  late final LoginUseCase _loginUseCase;
  LoginCubit():super(const LoginState())
  {
    _loadInjector();
  }
  _loadInjector()
  {
    _loginUseCase=injector();
  }


  void login(LoginInput input)async
  {
    emit(state.copyWith(loginState: RequestStatus.loading));
    try
    {
      await _loginUseCase.call(input);
      emit(state.copyWith(loginState: RequestStatus.success,));
    }
    catch(error)
    {
      emit(state.copyWith(loginState: RequestStatus.error,errorMessage: error.toString()));
    }
  }
}