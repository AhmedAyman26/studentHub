import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/services/domain/use_cases/get_subjects_use_case.dart';
import 'package:graduation/features/services/presentation/pages/subjects_page/subjects_state.dart';
import 'package:graduation/shared/utils.dart';

class SubjectsCubit extends Cubit<SubjectsState>
{
  SubjectsCubit(this._getSubjectsUseCase):super(const SubjectsState());

  static SubjectsCubit get(context)=>BlocProvider.of(context);

  final GetSubjectsUseCase _getSubjectsUseCase;

  void getSubjects(int facultyId)async
  {
    emit(state.copyWith(subjectsState: RequestStatus.loading));
    try{
      final subjects=await _getSubjectsUseCase.call(facultyId);
      emit(state.copyWith(subjectsState: RequestStatus.success,subjects: subjects));
    }catch(error)
    {
      emit(state.copyWith(subjectsState: RequestStatus.error));
    }
  }
}