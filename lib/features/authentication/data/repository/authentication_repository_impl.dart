import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/features/authentication/domain/repository/authentication_repository.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';
import 'package:graduation/shared/local/cache_helper.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository
{
  @override
  Future<void> registerDb(RegisterInput input) async{
    try {
      await DioHelper.postData(
          url: 'register.php', data: RegisterInput.toJson(isFirebase: false,input: input));
    }
    catch(error)
    {
      throw Exception(error.toString());
    }
  }

  @override
  Future<void> registerFb(RegisterInput input)async {
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: input.email, password: input.password).then((value)async
    {
      await FirebaseAuth.instance.currentUser!.updateDisplayName(input.fullName);
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      await _createUserFb(
        input: input,
      id : value.user!.uid,
      );
    });
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
    try
    {
      Response res = await DioHelper.getData(url: 'getfac.php');
      final data = jsonDecode(res.data)['faculty'];
      print(List<String>.from(data.map((fac) => fac['faculty_name'].toString()).toList()));
      return List<String>.from(data.map((fac) => fac['faculty_name'].toString()).toList());
    }catch(error)
    {
      throw Exception(error.toString());
    }
  }

  @override
  Future<List<String>> getUniversities() async{
    try
    {
      Response res = await DioHelper.getData(url: 'getuni.php');
      final data = jsonDecode(res.data)['university'];
      print( List<String>.from(data.map((fac) => fac['university_name'].toString()).toList()));
          return List<String>.from(data.map((fac) => fac['university_name'].toString()).toList());
    }catch(error)
    {
      throw Exception(error.toString());
    }
  }
}

