import 'package:get_it/get_it.dart';
import 'package:graduation/shared/preference_helper/preference_helper.dart';
import 'package:graduation/shared/preference_helper/preference_helper_impl.dart';
import 'package:graduation/shared/use_cases/cache_user_data_use_case.dart';
import 'package:graduation/shared/use_cases/get_cached_user_data_use_case.dart';
import 'package:graduation/shared/use_cases/logout_use_case.dart';

final injector = GetIt.instance;

class CommonDi {
  static Future<void> init() async {
    // usecases
    injector.registerFactory(() => CacheUserDataUseCase(injector()));
    injector.registerFactory(() => GetCachedUserDataUseCase(injector()));
    injector.registerFactory(() => LogoutUseCase(injector()));
    // repository
    injector.registerLazySingleton<PreferenceHelper>(() =>
        PreferenceHelperImpl(
        ));
  }
}