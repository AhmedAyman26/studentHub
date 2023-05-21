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
import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/register_cubit/states.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=> BlocProvider.of(context);

  static late UserModel userModel ;

  void userRegisterDb({
    required String fullname,
    required String email,
    // required String phone,
    required String university_id,
    required String faculty_id,
    required String password,
    // String? confirm,

  })async
  {
    emit(RegisterDbLoadingState());
    try {
      var res=await DioHelper.postData(
        url: 'register.php',
        data:
        {
          'fullname': fullname,
          'email': email,
          // 'phone': phone,
          'university_id': university_id,
          'faculty_id': faculty_id,
          'password': password,
          'image': "55"
          // 'confirm':confirm,
        },
      );
      // print(res.data);
      userModel =UserModel.fromJson(jsonDecode(res.data));
      await userRegisterFb(fullname: fullname, email: email, university_id: university_id, faculty_id: faculty_id, password: password);
      print(userModel.userData!.fullname);
      emit(RegisterDbSuccessState(userModel.userData!));
    }
    catch(error)
    {
      print(error);
      emit(RegisterDbErrorState(error.toString()));
    }
    //     .then((value)
    // {
    //   try
    //   {
    //     userModel= UserModel.fromJson(value as Map<String,dynamic>);
    //   }
    //   catch(error)
    //   {
    //     print(error);
    //   }
    //
    //   // print(registerModel.status);
    //   // print(registerModel.message);
    //   emit(RegisterDbSuccessState()) ;
    //
    // }).catchError((error){
    //   print(error.toString());
    //   emit(RegisterDbErrorState(error.toString()));
    // }) ;
  }

  userRegisterFb({
    required String fullname,
    required String email,
    // required String phone,
    required String university_id,
    required String faculty_id,
    required String password,
    String? uId,
    context
  })async
  {
    emit(RegisterFbLoadingState());

    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,

    ).then((value)async
    {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(fullname);
      CacheHelper.saveData(key: 'id', value: id=value.user!.uid);
      await userCreate(
        id : value.user!.uid,
      );
      emit(RegisterFbSuccessState());
    }).catchError((error)
    {
      throw Exception(error.toString());
      print(error.toString());
      emit(RegisterFbErrorState(error.toString()));
    });

  }

  userCreate({required String id})async
  {
    emit(CreateUserFbLoadingState());
    await FirebaseFirestore.instance.collection('users').doc(id).set(userModel.userData!.toJson()).then((value)async
    {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'uId':id
      });
      userModel.userData!.uId=id;
      emit(CreateUserFbSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(CreateUserFbErrorState(error.toString()));
    });
    // 'email': email,
    // 'username': name,
    // 'uId': value.user!.uid,
    // 'phone':phone,

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