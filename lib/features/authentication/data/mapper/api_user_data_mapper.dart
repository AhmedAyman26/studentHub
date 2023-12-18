import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/authentication/data/models/api_user_model.dart';

extension ApiUserDataMapper on ApiUserData
{
  UserData map()
  {
    return UserData(
      studentId: studentId??'',
      email: email??'',
      facultyName: facultyName??'',
      universityName: universityName??'',
      firebaseId: '',
      fullName: fullname??'',
      image: image??''
    );
  }
}