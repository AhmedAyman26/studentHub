class SubjectModel {
  List<Subjects>? subjects;

  SubjectModel({this.subjects});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subjects {
  String? subjectName;
  String? facultyName;
  int? subId;

  Subjects({this.subjectName, this.facultyName, this.subId});

  Subjects.fromJson(Map<String, dynamic> json) {
    subjectName = json['subject_name'];
    facultyName = json['faculty_name'];
    subId = json['sub_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subject_name'] = this.subjectName;
    data['faculty_name'] = this.facultyName;
    data['sub_id'] = this.subId;
    return data;
  }
}
