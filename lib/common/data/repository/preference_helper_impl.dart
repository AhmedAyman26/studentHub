import 'dart:convert';
import 'package:graduation/common/domain/repository/preference_helper.dart';
import 'package:graduation/common/utils/cache_helper.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';

class PreferenceHelperImpl extends PreferenceHelper
{
  @override
  Future<void> cacheUserData(UserData userData) async {
    CacheHelper.saveData(key: 'userData', value: jsonEncode(userData.toJson()));
  }

  @override
  Future<UserData?> getCachedUserData()async {
   final result=CacheHelper.getData(key: 'userData');
   if(result==null)
   {
     return null;
   }
   Map<String,dynamic> decoded= jsonDecode(result);
   return UserData(
     studentId: decoded['studentId'],
     fullName: decoded['fullName'],
     email: decoded['email'],
     facultyName: decoded['faculty'],
     universityName: decoded['university'],
     image: decoded['image'],
     firebaseId: decoded['firebaseId'],
     facultyId: decoded['faculty_Id']
   );
  }

  @override
  Future<bool> removeData(String key)async {
    return await CacheHelper.removeData(key: key);
  }

  @override
  Future<bool> saveData(String key, value) {
    // TODO: implement saveData
    throw UnimplementedError();
  }

}