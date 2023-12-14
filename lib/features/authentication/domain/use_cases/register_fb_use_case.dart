import 'package:graduation/features/authentication/domain/repository/authentication_repository.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';

class RegisterFbUseCase
{
  final AuthenticationRepository _authenticationRepository;

  RegisterFbUseCase(this._authenticationRepository);

  Future<void> call(RegisterInput input)async
  {
    return await _authenticationRepository.registerFb(input);
  }
}