import 'package:equatable/equatable.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/services/domain/models/subject_model.dart';

class SubjectsState extends Equatable {
  final RequestStatus? subjectsState;
  final List<SubjectModel>? subjects;

  const SubjectsState({this.subjectsState, this.subjects});

  SubjectsState copyWith(
      {RequestStatus? subjectsState, List<SubjectModel>? subjects}) {
    return SubjectsState(
        subjects: subjects ?? this.subjects,
        subjectsState: subjectsState ?? this.subjectsState);
  }

  @override
  List<Object?> get props =>[subjects,subjectsState];
}
