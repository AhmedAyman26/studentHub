import 'package:equatable/equatable.dart';

class UserData extends Equatable {
  final String? studentId;
  final String? fullName;
  final String? email;
  final String? image;
  final String? universityName;
  final String? facultyName;
  final String? firebaseId;
  final int? facultyId;

  const UserData({
    this.studentId,
    this.fullName,
    this.email,
    this.image,
    this.universityName,
    this.facultyName,
    this.firebaseId,
    this.facultyId,
  });

  const UserData.initial()
      : this(
            facultyId: 0,
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
      String? firebaseId,
      int? facultyId}) {
    return UserData(
        studentId: studentId ?? this.studentId,
        fullName: fullName ?? this.fullName,
        email: email ?? this.email,
        image: image ?? this.image,
        universityName: universityName ?? this.universityName,
        facultyName: facultyName ?? this.facultyName,
        firebaseId: firebaseId ?? this.firebaseId,
        facultyId: facultyId ?? this.facultyId);
  }

  Map<String, dynamic> toJson() {
    return {
      "studentId": studentId,
      "fullName": fullName,
      "email": email,
      "university": universityName,
      "faculty": facultyName,
      "image": image,
      "firebaseId": firebaseId,
      "facultyId": facultyId
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
        firebaseId,
        facultyId
      ];
}
