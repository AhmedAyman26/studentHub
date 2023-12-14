import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_cubit.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_state.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/logic/register_cubit/states.dart';
import 'package:graduation/presentation/screens/home.dart';
import 'package:graduation/presentation/screens/login/login_screen.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import 'package:graduation/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation/shared/utils.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: const RegisterPageBody(),
    );
  }
}

class RegisterPageBody extends StatefulWidget {
  const RegisterPageBody({super.key});

  @override
  State<RegisterPageBody> createState() => _RegisterPageBodyState();
}

class _RegisterPageBodyState extends State<RegisterPageBody> {

  int? selectedUniversity;
  int? selectedFaculty;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var universityController = TextEditingController();
  var facultyController = TextEditingController();
  var numberController = TextEditingController();
  var formkey = GlobalKey<FormState>();

  // var passwordController =TextEditingController();
  // var confirmController =TextEditingController();

  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpassword = TextEditingController();

  late String _name, _email, _phone;

  bool _obscureText = true;
  bool isPassword = true;

  // bool isVisible = false;
  // bool isPasswordEditingCharacter = false;
  // bool hasPasswordOneNumber = false;
  //bool isEmailCorrect = false;

  @override
  void initState() {
    RegisterCubit.get(context).getUniversities();
    RegisterCubit.get(context).getFaculties();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // onPasswordChanged(String password){
  //   final numRegex =RegExp(r'[0-9]');
  //   setState(() {
  //     isPasswordEditingCharacter = false;
  //     if(password.length >= 8) {
  //       isPasswordEditingCharacter = true;
  //     }
  //
  //     hasPasswordOneNumber =false;
  //     if(numRegex.hasMatch(password)) {
  //       hasPasswordOneNumber = true;
  //     }
  //   });
  //
  // }
  RegExp pass_validate = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double pass_strength = 0;

  bool validatePassword(String pass) {
    String password = pass.trim();
    if (password.isEmpty) {
      setState(() {
        pass_strength = 0;
      });
    } else if (password.length < 6) {
      setState(() {
        pass_strength = 1 / 4;
      });
    } else if (password.length < 8) {
      setState(() {
        pass_strength = 2 / 4;
      });
    } else {
      if (pass_validate.hasMatch(password)) {
        setState(() {
          pass_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          pass_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  //RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  // bool validatePassword (String path){
  //   String _password = pass.trim
  //
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state.registerState == RequestStatus.success) {
          navigateAndFinish(
            context,
            HomeLayout(),
          );
        }
      },
      builder: (context, state) {
        var cubit = RegisterCubit.get(context);
        if(state.faculties.isNotEmpty||state.universities.isNotEmpty)
        {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/signup.png'),
                        fit: BoxFit.fill,
                      )),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                      bottom: 15.h,
                      left: 50.w,
                      right: 50.w,
                    ),
                    child: Form(
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: InkWell(
                              onTap: () {
                                // RegisterCubit.get(context)
                                //     .addImageBottomSheet(context);
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo_outlined,
                                    color: Colors.grey[600],
                                  ),
                                  SizedBox(
                                    width: 5.h,
                                  ),
                                  Text(
                                    'Upload Your Picture',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey[600]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.enter_name;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(width: 3, color: Colors.black12),
                              ),
                              labelText:
                              AppLocalizations.of(context)!.full_name,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            // validator: ( value)
                            // {
                            //   if (value!.isEmpty)
                            //   {
                            //     return 'please enter email address!';
                            //   }
                            //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value))
                            //   {
                            //     return 'please enter valid email !';
                            //   }
                            //   return null;
                            // },
                            validator: (email) =>
                            email != null && !EmailValidator.validate(email)
                                ? AppLocalizations.of(context)!.enter_email
                                : null,
                            onSaved: (email) {
                              _email = email!;
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(width: 3, color: Colors.black12),
                              ),
                              labelText: AppLocalizations.of(context)!.email,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: numberController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!.enter_phon;
                              }
                              if (value.length < 10) {
                                return AppLocalizations.of(context)!
                                    .enter_vphon;
                              }
                              return null;
                            },
                            onSaved: (phone) {
                              _phone = phone!;
                            },
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                BorderSide(width: 3, color: Colors.black12),
                              ),
                              labelText: AppLocalizations.of(context)!.phone,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          // TextFormField(
                          //   controller: universityController,
                          //   keyboardType: TextInputType.name,
                          //   validator: (value)
                          //   {
                          //     if (value!.isEmpty)
                          //     {
                          //       return 'please enter university!';
                          //     }
                          //     return null;
                          //   },
                          //   decoration:const InputDecoration(
                          //     enabledBorder: UnderlineInputBorder(
                          //       borderSide: BorderSide(
                          //           width:3,
                          //           color:Colors.black12
                          //       ),
                          //     ),
                          //     labelText: 'University',
                          //   ),
                          // ),
                          DropdownButton(
                            items: state.universities.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                            onChanged: (e) {
                              selectedUniversity = e as int?;
                            },
                            isExpanded: true,
                            hint: Text(AppLocalizations.of(context)!
                                .select_university),
                            value:
                            selectedUniversity,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          DropdownButton(
                              items: state.faculties.map((e) => DropdownMenuItem(value: e,child: Text(e),)).toList(),
                              onChanged: (e) {
                                selectedFaculty=e as int?;
                              },
                              isExpanded: true,
                              hint: Text('select Your faculty'),
                              value:
                              selectedFaculty),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            //onChanged: (password) => onPasswordChanged(password),
                            controller: _password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .enter_password;
                              } else {
                                bool result = validatePassword(value);
                                if (!result) {
                                  return AppLocalizations.of(context)!
                                      .strong_pass;
                                }
                              }
                            },
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(width: 3, color: Colors.black12),
                              ),
                              labelText: AppLocalizations.of(context)!.password,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                    isPassword = !isPassword;
                                  });
                                },
                                icon: isPassword
                                    ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                                    : Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _confirmpassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .enter_cpassword;
                              }
                              if (_password.text != _confirmpassword.text) {
                                return AppLocalizations.of(context)!
                                    .pass_notmatch;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                BorderSide(width: 3, color: Colors.black12),
                              ),
                              labelText: AppLocalizations.of(context)!
                                  .confirm_password,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                    isPassword = !isPassword;
                                  });
                                },
                                icon: isPassword
                                    ? Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                                    : Icon(
                                  Icons.visibility,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          LinearProgressIndicator(
                            value: pass_strength,
                            backgroundColor: Colors.black12,
                            minHeight: 5,
                            color: pass_strength <= 1 / 4
                                ? Color.fromRGBO(70, 121, 112, 1.0)
                                : pass_strength == 2 / 4
                                ? Color.fromRGBO(70, 121, 112, 1.0)
                                : pass_strength == 3 / 4
                                ? Color.fromRGBO(70, 121, 112, 1.0)
                                : Color.fromRGBO(70, 121, 112, 1.0),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromRGBO(70, 121, 112, 1.0),
                              ),
                              child: MaterialButton(
                                onPressed: () async {
                                  if (formkey.currentState!.validate()) {
                                    cubit.registerUser(RegisterInput(nameController.text.trim(), emailController.text.trim(), _password.text.trim(), selectedUniversity.toString(), selectedFaculty.toString(), 'image'));
                                    // await cubit.userRegisterDb(
                                    //     fullname: nameController.text.trim(),
                                    //     email: emailController.text.trim(),
                                    //     // phone: numberController.text,
                                    //     university_id:
                                    //         RegisterCubit.get(context)
                                    //             .selectedUniversity!,
                                    //     faculty_id: RegisterCubit.get(context)
                                    //         .selectedFaculty!,
                                    //     password: _password.text.trim(),
                                    //     image: RegisterCubit.get(context)
                                    //         .profileImageLink);
                                    // await CacheHelper.saveData(
                                    //     key: 'facultyId',
                                    //     value: RegisterCubit.get(context)
                                    //         .selectedFaculty);
                                  } else {
                                    print(
                                        "******************************** llllllمدخلتش");
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.sign_up,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    //fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.have_account,
                              ),
                              TextButton(
                                onPressed: () {
                                  navigateTo(
                                    context,
                                    LoginScreen(),
                                  );
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.sign_in,
                                  style: TextStyle(
                                    color: Color.fromRGBO(70, 121, 112, 1.0),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }else
        {
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}
