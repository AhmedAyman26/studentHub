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
  late int id;
  late String fullname;
  late String email;
  // late String phone;
  late String university;
  late String faculty_id;
  late String password;
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
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    // phone = json['phone'];
    university = json['university'];
    faculty_id = json['faculty_id'];
    password = json['password'];
    // confirm = json['confirm'];

  }
}