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
  late String name;
  late String email;
  late String phone;
  late String university;
  late String faculty;
  late String password;
  late String confirm;
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
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    university = json['university'];
    faculty = json['faculty'];
    password = json['password'];
    confirm = json['confirm'];

  }
}