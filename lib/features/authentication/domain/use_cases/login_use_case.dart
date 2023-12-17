import 'package:graduation/features/authentication/domain/models/inputs/login_input.dart';
import 'package:graduation/features/authentication/domain/repository/authentication_repository.dart';

class LoginUseCase
{
  final AuthenticationRepository _authenticationRepository;

  LoginUseCase(this._authenticationRepository);

  Future<void> call(LoginInput input)
  {
    return _authenticationRepository.login(input);
  }
}