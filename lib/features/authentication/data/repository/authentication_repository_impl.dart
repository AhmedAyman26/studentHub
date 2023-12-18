import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/features/authentication/data/mapper/api_user_data_mapper.dart';
import 'package:graduation/features/authentication/data/models/api_user_model.dart';
import 'package:graduation/features/authentication/domain/models/inputs/login_input.dart';
import 'package:graduation/features/authentication/domain/repository/authentication_repository.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository
{
  @override
  Future<UserData> registerDb(RegisterInput input) async{
      final request=await DioHelper.postData(
          url: 'register.php', data: RegisterInput.toJson(isFirebase: false,input: input));
      if(request.statusCode!=200) {
        throw Exception();
      }else
      {
        final result=ApiUserModel.fromJson(jsonDecode(request.data)).data;
        return result!.map();
      }
  }

  @override
  Future<String> registerFb(RegisterInput input)async {
    String? firebaseId;
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: input.email, password: input.password).then((value)async
    {
      firebaseId=value.user?.uid;
      await FirebaseAuth.instance.currentUser!.updateDisplayName(input.fullName);
      // CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      await _createUserFb(
        input: input,
      id : value.user!.uid,
      );
    });
    return firebaseId??'';
  }

  _createUserFb({required String id,required RegisterInput input})async {
    await FirebaseFirestore.instance.collection('users').doc(id).set(RegisterInput.toJson(isFirebase: true, input: input)).then((value)async
    {
      await FirebaseFirestore.instance.collection('users').doc(id).update({
        'uId':id
      });
  });
}

  @override
  Future<List<String>> getFaculties() async{
      Response res = await DioHelper.getData(url: 'getfac.php');
      if (res.statusCode != 200) {
        throw Exception(res.statusMessage);
      }
      final data = jsonDecode(res.data)['faculty'];
      return List<String>.from(
          data.map((fac) => fac['faculty_name'].toString()).toList());
    }

  @override
  Future<List<String>> getUniversities() async{
      Response res = await DioHelper.getData(url: 'getuni.php');
      if(res.statusCode!=200)
      {
        throw Exception(res.statusMessage);
      }
      final data = jsonDecode(res.data)['university'];
          return List<String>.from(data.map((fac) => fac['university_name'].toString()).toList());
  }

  @override
  Future<UserData> login(LoginInput input) async{
      final request=await DioHelper.postData(
          url: 'login.php', data: LoginInput.toJson(input));
      if(request.statusCode!=200)
      {
        throw Exception();
      }else
      {
        final result=ApiUserModel.fromJson(jsonDecode(request.data)).data;
        return result!.map();
      }
  }
}

