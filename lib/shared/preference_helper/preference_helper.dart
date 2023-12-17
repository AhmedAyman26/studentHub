import 'package:graduation/data/models/user_model.dart';

abstract class PreferenceHelper
{
  Future<void> cacheUserData(UserModel userModel);
  Future<UserModel> getCachedUserData();
  Future<bool> saveData(String key,dynamic value);
  Future<bool> removeData(String key);
}