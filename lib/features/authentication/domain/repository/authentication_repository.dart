import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/authentication/domain/models/inputs/login_input.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';

abstract class AuthenticationRepository
{
  Future<List<String>> getUniversities();
  Future<List<String>> getFaculties();
  Future<UserData> registerDb(RegisterInput input);
  Future<String> registerFb(RegisterInput input);
  Future<UserData> login(LoginInput input);
}