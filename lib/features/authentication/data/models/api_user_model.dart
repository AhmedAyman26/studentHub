class ApiUserModel {
  final ApiUserData? data;
  final String? message;

  ApiUserModel({
    this.data,
    this.message,
  });

  factory ApiUserModel.fromJson(Map<String, dynamic> json) => ApiUserModel(
    data: json["data"] == null ? null : ApiUserData.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "message": message,
  };
}

class ApiUserData {
  final String? fullname;
  final String? email;
  final String? image;
  final String? studentId;
  final String? universityName;
  final String? facultyName;
  final String? password;
  final String? firebaseId;

  ApiUserData({
    this.fullname,
    this.email,
    this.image,
    this.studentId,
    this.universityName,
    this.facultyName,
    this.password,
    this.firebaseId
  });

  factory ApiUserData.fromJson(Map<String, dynamic> json) => ApiUserData(
    fullname: json["fullname"],
    email: json["email"],
    image: json["image"],
    studentId: json["student_id"],
    universityName: json["university_name"],
    facultyName: json["faculty_name"],
    password: json["Password"],
    firebaseId: json['uId']
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "email": email,
    "image": image,
    "student_id": studentId,
    "university_name": universityName,
    "faculty_name": facultyName,
    "Password": password,
  };
}
