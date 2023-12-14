import 'package:graduation/features/authentication/domain/repository/authentication_repository.dart';

class GetFacultiesUseCase
{
  final AuthenticationRepository _authenticationRepository;

  GetFacultiesUseCase(this._authenticationRepository);

  Future<List<String>> call()async
  {
    return await _authenticationRepository.getFaculties();
  }
}