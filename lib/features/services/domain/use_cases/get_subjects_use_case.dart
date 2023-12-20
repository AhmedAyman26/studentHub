import 'package:graduation/features/services/domain/models/subject_model.dart';
import 'package:graduation/features/services/domain/repository/services_repository.dart';

class GetSubjectsUseCase
{
  final ServicesRepository _servicesRepository;

  GetSubjectsUseCase(this._servicesRepository);

  Future<List<SubjectModel>> call(int facultyId)async
  {
    return await _servicesRepository.getSubjects(facultyId);
  }
}