// class UserModel
// {
//   String? name;
//   String? email;
//   String? phone;
//   String? id;
//   String? image;
//   String? university;
//   String? faculty;
//
//   UserModel({
//     this.name,
//     this.email,
//     this.phone,
//     this.id,
//     this.image,
//     this.faculty,
//     this.university,
//   });
//   UserModel.fromJson(Map<String,dynamic>json)
//   {
//     name=json['name'];
//     email=json['email'];
//     phone=json['phone'];
//     id=json['id'];
//     image=json['image'];
//     university=json['university'];
//     faculty=json['faculty'];
//   }
//   Map<String,dynamic> toMap()
//   {
//     return
//       {
//         'username':name,
//         'email':email,
//         'phone':phone,
//         'id':id,
//         'image':image,
//         'university':university,
//         'faculty':faculty
//       };
//   }
// }
class RegisterModel
{
  late bool status;
  late String message;
  late UserData data;

  RegisterModel.fromJson(Map<String ,dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? UserData.fromJson(json['data']) : null)!;
  }
}

class UserData
{
  late String id;
  late String fullname;
  late String email;
  // late String phone;
  late String university_id;
  late String faculty_id;
  late String password;
  late String image;
  // late String confirm;
//الكونستركتور دا بياخد الداتا
//   UserData({
//     required this.id,
//     required this.name,
//     required this.email,
//     required this.phone,
//     required this.university,
//     required this.faculty,
//     required this.password,
//     required this.confirm,
// });
//دا النيم كونستركتور بيرجج الداتا علي شكل جيسون
  UserData.fromJson(Map<String ,dynamic> json)
  {
    id = json['studentId'];
    fullname = json['fullname'];
    email = json['email'];
    // phone = json['phone'];
    university_id = json['university_id'];
    faculty_id = json['facultyId'];
    password = json['password'];
    image=json['image'];
    // confirm = json['confirm'];

  }
  Map<String,dynamic> toMap()
  {
    return
      {
        'fullname':fullname,
        'email':email,
        'id':id,
        'image':image,
        'university_id':university_id,
        'faculty_id':faculty_id
      };
  }
}

/*class RegisterModel {
  RegisterModel({
    required this.user,
    required this.message,
  });
  late final User user;
  late final String message;

  RegisterModel.fromJson(Map<String, dynamic> json){
    user = User.fromJson(json['user']);
    message = json['message'];
  }

}

class User {
  User({
    required this.fullname,
    required this.email,
    required this.image,
    required this.universityName,
    required this.facultyName,
    required this.Password,
  });
  late final String fullname;
  late final String email;
  late final String image;
  late final String universityName;
  late final String facultyName;
  late final String Password;

  User.fromJson(Map<String, dynamic> json){
    fullname = json['fullname'];
    email = json['email'];
    image = json['image'];
    universityName = json['university_name'];
    facultyName = json['faculty_name'];
    Password = json['Password'];
  }


}*/