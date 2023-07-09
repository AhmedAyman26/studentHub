class UserModel {
  UserData? userData;
  String? message;

  UserModel({this.userData, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    userData = json['user'] != null ?  UserData.fromJson(json['user']) : null;
    message = json['message'];
  }

}

class UserData {
  String? uId;
  String? student_id;
  String? fullname;
  String? email;
  String? image;
  String? universityName;
  String? facultyName;
  String? password;
  String? firebase_id;

  UserData(
      {
        this.uId,
        this.student_id,
        this.fullname,
        this.email,
        this.image,
        this.universityName,
        this.facultyName,
        this.password,
        this.firebase_id
      });

  UserData.fromJson(Map<String, dynamic> json) {
    uId=json['uId'];
    student_id=json['student_id'];
    fullname = json['fullname'];
    email = json['email'];
    image = json['image'];
    universityName = json['university_name'];
    facultyName = json['faculty_name'];
    password = json['Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['uId']=this.uId;
    data['student_id']=this.student_id;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['image'] = this.image;
    data['university_name'] = this.universityName;
    data['faculty_name'] = this.facultyName;
    data['Password'] = this.password;
    return data;
  }
}