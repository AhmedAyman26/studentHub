// import 'package:awesome_dialog/awesome_dialog.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:graduation/data/models/user_model.dart';
// import 'package:graduation/logic/register_cubit/states.dart';
//
// class RegisterCubit extends Cubit<RegisterStates>{
//   RegisterCubit() : super(RegisterInitialState());
//
//   static RegisterCubit get(context)=>BlocProvider.of(context);
//
//   void userRegister({
//     required String name,
//     required String email,
//     required String password,
//     required String phone,
//     String? id,
//     required String? faculty,
//     required String? university,
//     context,
//   })async
//   {
//     emit(RegisterLoadingState());
//
//     await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//
//     ).then((value)async
//     {
//       userCreate(
//         email: email,
//         name: name,
//         phone: phone,
//         faculty: faculty,
//         university: university,
//         id: value.user!.uid,
//       );
//       emit(RegisterSuccessState());
//     }).catchError((error)
//     {
//       if (error.code == 'weak-password') {
//         AwesomeDialog(
//             context: context,
//             title: "Error",
//             body: Text("Password is to weak"))
//           ..show();
//       } else if (error.code == 'email-already-in-use') {
//         AwesomeDialog(
//             context: context,
//             title: "Error",
//             body: Text("The account already exists for that email"))
//           ..show();
//       }});
//
//   }
//
//   void userCreate({
//     required String email,
//     required String name,
//     required String phone,
//     required String? id,
//     required String? faculty,
//     required String? university,
//
//   })async
//   {
//     UserModel model=UserModel(
//         name: name,
//         email: email,
//         phone: phone,
//         id: id,
//         image: 'https://img.freepik.com/premium-photo/young-caucasian-man-isolated-blue-background-pointing-front-with-fingers_1187-239271.jpg?w=740',
//         faculty: faculty,
//       university: university,
//     );
//     FirebaseFirestore.instance.collection('users').doc(id).set(model.toMap()).then((value)
//     {
//       emit(CreateUserSuccessState());
//     }).catchError((error)
//     {
//       emit(CreateUserErrorState(error.toString()));
//     });
//     // 'email': email,
//     // 'username': name,
//     // 'uId': value.user!.uid,
//     // 'phone':phone,
//
//   }
//   IconData suffix = Icons.remove_red_eye;
//   bool isPassword = true;
//   void changePasswordVisibility() {
//     isPassword = isPassword;
//     suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off;
//     emit(RegisterChangePasswordVisibilityState());
//   }
//
// }
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
    required String fullname,
    required String email,
    // required String phone,
    required String university,
    required String faculty_id,
    required String password,
    // String? confirm,

  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: 'register.php',
      data:
      {
        'fullname': fullname,
        'email':email,
        // 'phone': phone,
        'university_id':university,
        'faculty_id':faculty_id,
        'password':password,
        // 'confirm':confirm,
      },
    ).then((value)
    {
      print(value.data);
      // registerModel = RegisterModel.fromJson(value.data);
      // print(registerModel.status);
      // print(registerModel.message);
      emit(RegisterSuccessState()) ;
    }).catchError((error){
      print(error.toString());
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