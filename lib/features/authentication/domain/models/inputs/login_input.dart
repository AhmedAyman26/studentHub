class LoginInput{
  final String email;
  final String password;

  LoginInput(this.email, this.password);

  static Map<String,dynamic> toJson(LoginInput input)
  {
    return
      {
        "email":input.email,
        "password":input.password
      };
  }
}