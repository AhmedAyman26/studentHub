import 'dart:convert';

import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/features/services/data/mappers/api_subject_mapper.dart';
import 'package:graduation/features/services/data/models/api_subject_model.dart';
import 'package:graduation/features/services/domain/models/subject_model.dart';
import 'package:graduation/features/services/domain/repository/services_repository.dart';

class ServiceRepositoryImpl extends ServicesRepository
{
  @override
  Future<List<SubjectModel>> getSubjects(int facultyId)async {
   final request=await DioHelper.getData(url: 'getsubj.php',query: {'faculty_id':facultyId});
   if(request.statusCode!=200) {
     throw Exception(request.statusMessage);
   }else
   {
     final result=ApiSubjectModel.fromJson(jsonDecode(request.data)).subjects;
     return result?.map((e) => e.map()).toList()??[];
   }
  }

}
