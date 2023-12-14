import 'package:get_it/get_it.dart';
import 'package:graduation/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:graduation/features/authentication/domain/repository/authentication_repository.dart';
import 'package:graduation/features/authentication/domain/use_cases/get_faculties_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/get_universities_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/register_db_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/register_fb_use_case.dart';

final injector = GetIt.instance;
class AuthenticationDi {
  static Future<void> init() async {
    // usecases
    injector.registerFactory(() => RegisterDbUseCase(injector()));
    injector.registerFactory(() => RegisterFbUseCase(injector()));
    injector.registerFactory(() => GetUniversitiesUseCase(injector()));
    injector.registerFactory(() => GetFacultiesUseCase(injector()));
    // repository
    injector.registerLazySingleton<AuthenticationRepository>(() =>
        AuthenticationRepositoryImpl(
        ));
  }
}