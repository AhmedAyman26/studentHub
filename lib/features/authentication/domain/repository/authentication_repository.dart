import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';

abstract class AuthenticationRepository
{
  Future<List<String>> getUniversities();
  Future<List<String>> getFaculties();
  Future<void> registerDb(RegisterInput input);
  Future<void> registerFb(RegisterInput input);
}