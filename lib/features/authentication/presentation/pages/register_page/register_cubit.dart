import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';
import 'package:graduation/features/authentication/domain/use_cases/get_faculties_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/get_universities_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/register_db_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/register_fb_use_case.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_state.dart';
import 'package:graduation/features/posts/di/posts_di.dart';

class RegisterCubit extends Cubit<RegisterState> {
  late final RegisterDbUseCase _registerDbUseCase;
  late final RegisterFbUseCase _registerFbUseCase;
  late final GetUniversitiesUseCase _getUniversitiesUseCase;
  late final GetFacultiesUseCase _getFacultiesUseCase;

  RegisterCubit() : super(const RegisterState()) {
    _loadInjector();
  }

  _loadInjector() {
    _registerDbUseCase = injector();
    _registerFbUseCase = injector();
    _getUniversitiesUseCase = injector();
    _getFacultiesUseCase = injector();
  }

  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser(RegisterInput input) async {
    emit(state.copyWith(registerState: RequestStatus.loading));
    try {
      final userData=await _registerDbUseCase.call(input);
      String firebaseId=await _registerFbUseCase.call(input);
      print("firebase$firebaseId");
      final updatedUserData=userData.modify(firebaseId: firebaseId);
      emit(state.copyWith(registerState: RequestStatus.success,userData: updatedUserData));
    }
    catch(e)
    {
      print(e.toString());
      emit(state.copyWith(registerState: RequestStatus.error,errorMessage: e.toString()));
    }
  }

  void getUniversities() async {
    try {
      emit(state.copyWith(getUniversitiesState: RequestStatus.loading));
      final universities = await _getUniversitiesUseCase.call();
      emit(state.copyWith(
          universities: universities,
          getUniversitiesState: RequestStatus.success));
    } catch (error) {
      emit(state.copyWith(
          errorMessage: error.toString(),
          getUniversitiesState: RequestStatus.error));
    }
  }

  void getFaculties() async {
    try {
      emit(state.copyWith(getFacultiesState: RequestStatus.loading));
      final faculties = await _getFacultiesUseCase.call();
      emit(state.copyWith(
          getFacultiesState: RequestStatus.success, faculties: faculties));
    } catch (error) {
      emit(state.copyWith(
          getFacultiesState: RequestStatus.error,
          errorMessage: error.toString()));
    }
  }
}
