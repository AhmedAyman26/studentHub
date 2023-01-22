import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/register_cubit/states.dart';

class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=> BlocProvider.of(context);

  late RegisterModel registerModel ;

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String university,
    required String faculty,
    required String password,
    required String confirm,

  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: '/register',
      data:
      {
        'name': name,
        'email':email,
        'phone': phone,
        'university':university,
        'faculty':faculty,
        'password':password,
        'confirm':confirm,
      },
    ).then((value)
    {
      print(value.data);
      registerModel = RegisterModel.fromJson(value.data);
      // print(registerModel.status);
      // print(registerModel.message);
      emit(RegisterSuccessState(registerModel)) ;
    }).catchError((error){
      emit(RegisterErrorState(error.toString()));
    }) ;
  }

// IconData suffix = Icons.visibility_outlined;
// bool isPassword = true;
//
// void ChangePasswordVisibility(){
//   isPassword = !isPassword;
//   suffix = isPassword ?Icons.visibility_outlined : Icons.visibility_off_outlined;
//
//   emit(PasswordVisibilityState());
//
// }

}