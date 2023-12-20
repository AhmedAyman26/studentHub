import 'package:get_it/get_it.dart';
import 'package:graduation/features/services/data/repository/service_repository_impl.dart';
import 'package:graduation/features/services/domain/repository/services_repository.dart';
import 'package:graduation/features/services/domain/use_cases/get_subjects_use_case.dart';

final injector = GetIt.instance;

class ServicesDi
{
  static Future<void> init() async {
    // usecases
    injector.registerFactory(() => GetSubjectsUseCase(injector()));
    // repository
    injector.registerLazySingleton<ServicesRepository>(() =>
        ServiceRepositoryImpl(
        ));
  }
}