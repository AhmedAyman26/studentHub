import 'package:graduation/features/authentication/domain/models/user_model.dart';

abstract class PreferenceHelper
{
  Future<void> cacheUserData(UserData userData);
  Future<UserData?> getCachedUserData();
  Future<bool> saveData(String key,dynamic value);
  Future<bool> removeData(String key);
}