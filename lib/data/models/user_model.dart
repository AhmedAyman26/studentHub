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
  String? fullname;
  String? email;
  String? image;
  String? universityName;
  String? facultyName;
  String? password;

  UserData(
      {
        this.uId,
        this.fullname,
        this.email,
        this.image,
        this.universityName,
        this.facultyName,
        this.password});

  UserData.fromJson(Map<String, dynamic> json) {
    uId=json['uId'];
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
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['image'] = this.image;
    data['university_name'] = this.universityName;
    data['faculty_name'] = this.facultyName;
    data['Password'] = this.password;
    return data;
  }
}