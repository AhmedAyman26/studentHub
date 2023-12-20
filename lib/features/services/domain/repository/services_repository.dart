import 'package:graduation/features/services/domain/models/subject_model.dart';

abstract class ServicesRepository
{
  Future<List<SubjectModel>> getSubjects(int facultyId);
}