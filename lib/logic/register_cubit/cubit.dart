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
import 'package:dio/dio.dart';
import 'package:graduation/data/models/subject_model.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/register_cubit/states.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context)=> BlocProvider.of(context);

  var profileImagePicker=ImagePicker();
  File? profileImageFile;
  var profileImageLink;
  Future addImageBottomSheet(context) async{
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please Choose Image',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  var picked =
                  await profileImagePicker.pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    profileImageFile = File(picked.path);
                    var imageName = basename(picked.path);
                    // convertImageToBase64(picked as File);
                    // imageToAPI =await convertImageToBase64(file!);
                    await FirebaseStorage.instance.ref()
                        .child('users/${Uri.file(profileImageFile!.path).pathSegments.last}')
                        .putFile(profileImageFile!).then((value)  {
                      value.ref.getDownloadURL().then((value) {
                        print(value);
                        profileImageLink=value;
                        // emit(SocialUploadProfileImageSuccessState());
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'From Gallery',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  var picked =
                  await ImagePicker().pickImage(source: ImageSource.camera);
                  if (picked != null) {
                    profileImageFile = File(picked.path);
                    var imageName = basename(picked.path);
                    // convertImageToBase64(picked as File);
                    await FirebaseStorage.instance.ref()
                        .child('users/${Uri.file(profileImageFile!.path).pathSegments.last}')
                        .putFile(profileImageFile!).then((value)  {
                      value.ref.getDownloadURL().then((value) {
                        print(value);
                        profileImageLink=value;
                        // emit(SocialUploadProfileImageSuccessState());
                      });
                    });
                    // imageToAPI =await convertImageToBase64(file!);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'From Camera',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  static late UserModel userModel ;

  Future userRegisterDb({
    required String fullname,
    required String email,
    // required String phone,
    required int university_id,
    required int faculty_id,
    required String password,
    String? image,
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
          'image': image==null?'https://www.vhv.rs/dpng/d/312-3120300_default-profile-hd-png-download.png':image
          // 'confirm':confirm,
        },
      );
      // print(res.data);
      userModel =UserModel.fromJson(jsonDecode(res.data));
      await userRegisterFb(fullname: fullname, email: email, university_id: university_id, faculty_id: faculty_id, password: password);
      print(userModel.userData!.fullname);
      print(userModel.userData!.student_id);
      await CacheHelper.saveData(key: 'sId', value: userModel.userData!.student_id);
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
    required int university_id,
    required int faculty_id,
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
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
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

  int? selectedUniversity;
  changeSelectedUniversity(value) {
    selectedUniversity = value;
    emit(ChangeSelectedUniState());
  }
  List<dynamic>universities=[];
  List<DropdownMenuItem> uItems=[];
  void getUni() async {
    Response res = await DioHelper.getData(url: 'getuni.php');
    List<dynamic> data = jsonDecode(res.data)['university'];
    universities = data.map((fac) => fac['university_name']).toList();
    print(universities);
    uItems = universities.asMap().entries.map<DropdownMenuItem<int>>((entry) {
      int index = entry.key+1;
      String universityName = entry.value;
      return DropdownMenuItem<int>(
        child: Text(universityName),
        value: index,
      );
    }).toList();
  }

  int? selectedFaculty;
  changeSelectedFaculty(value) {
    selectedFaculty = value;
    emit(ChangeSelectedFacultyState());
  }
  List<dynamic> faculties = [];
  List<DropdownMenuItem<int>> fItems = [];

  void getFac() async {
    Response res = await DioHelper.getData(url: 'getfac.php');
    List<dynamic> data = jsonDecode(res.data)['faculty'];
    faculties = data.map((fac) => fac['faculty_name']).toList();
    print(faculties);
    fItems = faculties.asMap().entries.map<DropdownMenuItem<int>>((entry) {
      int index = entry.key+1;
      String facultyName = entry.value;
      return DropdownMenuItem<int>(
        child: Text(facultyName),
        value: index,
      );
    }).toList();
  }


}