class UniversityModel {
  List<University>? university;

  UniversityModel({this.university});

  UniversityModel.fromJson(Map<String, dynamic> json) {
    if (json['university'] != null) {
      university = <University>[];
      json['university'].forEach((v) {
        university!.add(new University.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.university != null) {
      data['university'] = this.university!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class University {
  String? universityName;

  University({this.universityName});

  University.fromJson(Map<String, dynamic> json) {
    universityName = json['university_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['university_name'] = this.universityName;
    return data;
  }
}