import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/shared/cubits/user_cubit/user_state.dart';
import 'package:graduation/shared/use_cases/cache_user_data_use_case.dart';
import 'package:graduation/shared/use_cases/get_cached_user_data_use_case.dart';
import 'package:graduation/shared/use_cases/logout_use_case.dart';
import 'package:graduation/shared/utils.dart';

class UserCubit extends Cubit<UserState>
{
  late final CacheUserDataUseCase _cacheUserDataUseCase;
  late final LogoutUseCase _logoutUseCase;

  late final GetCachedUserDataUseCase _getCachedUserDataUseCase;
  UserCubit():super(const UserState())
  {
    _loadInjector();
  }

  _loadInjector()
  {
    _cacheUserDataUseCase=injector();
    _getCachedUserDataUseCase=injector();
    _logoutUseCase=injector();
  }
  static UserCubit get(context)=>BlocProvider.of(context);

  void cacheUser(UserData userData)async
  {
    emit(state.copyWith(userDataState: RequestStatus.loading));
    await _cacheUserDataUseCase.call(userData);
    emit(state.copyWith(userDataState: RequestStatus.success,userData: userData));
  }

  void getCachedUserData()async
  {
    emit(state.copyWith(userDataState: RequestStatus.loading));
    final userData=await _getCachedUserDataUseCase.call();
    emit(state.copyWith(userData: userData,userDataState: RequestStatus.success));
  }

  void logout(String key)async
  {
    emit(state.copyWith(logout: RequestStatus.loading));
    await _logoutUseCase.call(key);
    resetScopeDependencies();
    emit(state.copyWith(logout: RequestStatus.success));
}
}