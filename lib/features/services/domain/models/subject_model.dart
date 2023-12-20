import 'package:equatable/equatable.dart';

class SubjectModel extends Equatable
{
  final String? subjectName;
  final String? facultyName;
  final int? subjectId;

  const SubjectModel({this.subjectName, this.facultyName, this.subjectId});

  @override
  List<Object?> get props => [subjectName,facultyName,subjectId];
}