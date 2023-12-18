import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String? studentId;
  final String? fullName;
  final String? email;
  final String? image;
  final String? universityName;
  final String? facultyName;
  final String? firebaseId;

  const UserData(
      {this.studentId,
      this.fullName,
      this.email,
      this.image,
      this.universityName,
      this.facultyName,
      this.firebaseId});

  const UserData.initial()
      : this(
            firebaseId: '',
            studentId: '',
            fullName: '',
            email: '',
            facultyName: '',
            universityName: '',
            image: '');

  UserData modify(
      {String? studentId,
      String? fullName,
      String? email,
      String? image,
      String? universityName,
      String? facultyName,
      String? firebaseId}) {
    return UserData(
        studentId: studentId ?? this.studentId,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        image: image ?? this.image,
        universityName: universityName ?? this.universityName,
        facultyName: facultyName ?? this.facultyName,
        firebaseId: firebaseId ?? this.firebaseId);
  }

  Map<String,dynamic> toJson()
  {
    return
      {
        "studentId":studentId,
        "fullName":fullName,
        "email":email,
        "university":universityName,
        "faculty":facultyName,
        "image":image,
        "firebaseId":firebaseId
      };
  }

  @override
  List<Object?> get props => [
        studentId,
        fullName,
        email,
        image,
        facultyName,
        universityName,
        firebaseId
      ];
}
