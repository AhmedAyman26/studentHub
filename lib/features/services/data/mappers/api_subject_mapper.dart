import 'package:graduation/features/services/data/models/api_subject_model.dart';
import 'package:graduation/features/services/domain/models/subject_model.dart';

extension ApiSubjectMapper on ApiSubject {
  SubjectModel map() {
    return SubjectModel(
        subjectName: subjectName ?? '',
        facultyName: facultyName ?? '',
        subjectId: subId ?? 0);
  }
}
