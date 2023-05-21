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