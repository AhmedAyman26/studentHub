class RegisterInput
{
  final String fullName;
  final String email;
  final String password;
  final String universityId;
  final String facultyId;
  final String image;

  RegisterInput(this.fullName, this.email, this.password, this.universityId, this.facultyId, this.image);


  static Map<String,dynamic> toJson({required bool isFirebase,required RegisterInput input})
  {
    return
      {
        "fullname":input.fullName,
        "email":input.email,
        !isFirebase?"password":input.password:null,
        "university_id":input.universityId,
        "faculty_id":input.facultyId,
        "image":input.image
      };
  }
}