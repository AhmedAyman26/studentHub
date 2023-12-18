import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/authentication/domain/repository/authentication_repository.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';

class RegisterDbUseCase
{
  final AuthenticationRepository _authenticationRepository;

  RegisterDbUseCase(this._authenticationRepository);

  Future<UserData> call(RegisterInput input)async
  {
    return await _authenticationRepository.registerDb(input);
  }
}