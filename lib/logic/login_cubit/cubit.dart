import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/logic/login_cubit/states.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  userLogin({
    required String email,
    required String password,
    context
  })async
  {
    try {
      emit(LoginLoadingState());
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((value) {
        CacheHelper.saveData(key: 'id', value: value.user!.uid);
        emit(LoginSuccessState(value.user!.uid));
        print(value.user!.uid);
      });
    }
    on FirebaseAuthException catch(e)
    {
      if (e.code == 'user-not-found') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("No user found for that email"))
          ..show();
      } else if (e.code == 'wrong-password') {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("Wrong password provided for that user."))
          ..show();
      }
      else
      {
        AwesomeDialog(
            context: context,
            title: "Error",
            body: Text("No user found for that email"))
          ..show();
      }
      emit(LoginErrorState(e.toString()));
    }
    catch(e)
    {
      print(e);
    }
  }
// userLogin({
//   required String email,
//   required String password,
//   context
// })async {
//   emit(LoginLoadingState());
//   await FirebaseAuth.instance.signInWithEmailAndPassword(
//     email: email,
//     password: password,
//   ).then((value) {
//     id=value.user!.uid;
//     emit(LoginSuccessState(value.user!.uid));
//     print(value.user!.uid);
//   }).catchError((e)
//   {
//     print(e.toString());
//     if (e.code == 'user-not-found') {
//       AwesomeDialog(
//           context: context,
//           title: "Error",
//           body: Text("No user found for that email"))
//         ..show();
//     } else if (e.code == 'wrong-password') {
//       AwesomeDialog(
//           context: context,
//           title: "Error",
//           body: Text("Wrong password provided for that user."))
//         ..show();
//     }
//     else
//     {
//       AwesomeDialog(
//           context: context,
//           title: "Error",
//           body: Text("No user found for that email"))
//         ..show();
//     }
//     emit(LoginErrorState(e.toString()));
//   });
// }
// IconData suffix = Icons.remove_red_eye;
// bool isPassword = true;
// void changePasswordVisibility() {
//   isPassword = !isPassword;
//   suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
//   emit(ChangePasswordVisibilityState());
// }
}
