import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';
import 'package:graduation/features/authentication/domain/use_cases/get_faculties_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/get_universities_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/register_db_use_case.dart';
import 'package:graduation/features/authentication/domain/use_cases/register_fb_use_case.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_state.dart';
import 'package:graduation/features/posts/di/posts_di.dart';
import 'package:graduation/shared/utils.dart';

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
    await _registerDbUseCase.call(input);
    await _registerFbUseCase.call(input);
  }

  void getUniversities() async {
    try {
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
