class ApiSubjectModel {
  final List<ApiSubject>? subjects;

  ApiSubjectModel({
    this.subjects,
  });

  factory ApiSubjectModel.fromJson(Map<String, dynamic> json) => ApiSubjectModel(
    subjects: json["subjects"] == null ? [] : List<ApiSubject>.from(json["subjects"]!.map((x) => ApiSubject.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
  };
}

class ApiSubject {
  final String? subjectName;
  final String? facultyName;
  final int? subId;

  ApiSubject({
    this.subjectName,
    this.facultyName,
    this.subId,
  });

  factory ApiSubject.fromJson(Map<String, dynamic> json) => ApiSubject(
    subjectName: json["subject_name"],
    facultyName: json["faculty_name"],
    subId: json["sub_id"],
  );

  Map<String, dynamic> toJson() => {
    "subject_name": subjectName,
    "faculty_name": facultyName,
    "sub_id": subId,
  };
}
