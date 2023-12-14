import 'package:graduation/features/authentication/domain/repository/authentication_repository.dart';

class GetUniversitiesUseCase
{
  final AuthenticationRepository _authenticationRepository;

  GetUniversitiesUseCase(this._authenticationRepository);

  Future<List<String>> call()async
  {
    return await _authenticationRepository.getUniversities();
  }
}