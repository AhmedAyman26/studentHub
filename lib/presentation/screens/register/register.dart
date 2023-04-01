import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/logic/register_cubit/cubit.dart';
import 'package:graduation/logic/register_cubit/states.dart';
import 'package:graduation/presentation/screens/Home.dart';
import 'package:graduation/presentation/screens/login/login_screen.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import 'package:graduation/shared/styles/colors.dart';

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var universityController =TextEditingController();
  var facultyController =TextEditingController();
  var numberController =TextEditingController();
  var formkey =GlobalKey<FormState>();
  // var passwordController =TextEditingController();
  // var confirmController =TextEditingController();

  TextEditingController _password =TextEditingController();
  TextEditingController _confirmpassword =TextEditingController();

  late String _name,_email,_phone;


  bool _obscureText = true;
  bool isPassword = true;
  // bool isVisible = false;
  // bool isPasswordEditingCharacter = false;
  // bool hasPasswordOneNumber = false;
  //bool isEmailCorrect = false;
  void disValid (){
    emailController.dispose();
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

  bool validatePassword(String pass){
    String password = pass.trim();
    if(password.isEmpty){
      setState(() {
        pass_strength = 0;
      });
    }else if(password.length < 6){
      setState(() {
        pass_strength = 1/4 ;
      });
    }else if(password.length < 8){
      setState(() {
        pass_strength = 2/4 ;
      });
    }else{
      if(pass_validate.hasMatch(password)){
        setState(() {
          pass_strength = 4/4 ;
        });
        return true;
      }else{
        setState(() {
          pass_strength = 3/4 ;
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
    final size=MediaQuery.of(context).size;
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) async{
          if(state is RegisterSuccessState){
              navigateAndFinish(
                context,
                  const HomeLayout(),
              );
          }
        },
        builder: (context, state) {
          var cubit =RegisterCubit.get(context);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize:const Size.fromHeight(150),
              child: AppBar(
                backgroundColor:const Color.fromRGBO(70, 121, 112, 1.0),
                leading:const Icon(
                  Icons.arrow_back,
                ),
                title:const Text(
                    'Create Account'
                ),
                shape:const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                  ),
                ),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(50),
              child: SingleChildScrollView(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter full name!';
                          }
                          return null;
                        },
                        decoration:const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width:3,
                                color:Colors.black12
                            ),
                          ),
                          labelText: 'Full Name',
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
                        validator: (email) => email != null && ! EmailValidator.validate(email) ?
                        "please enter a valid email" : null,
                        onSaved: ( email){
                          _email = email!;
                        },
                        decoration:const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width:3,
                                color:Colors.black12
                            ),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        validator: ( value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter phone number!';
                          }
                          if (value.length < 10)
                          {
                            return 'please enter valid phone !';
                          }
                          return null;
                        },
                        onSaved: ( phone){
                          _phone = phone!;
                        },
                        decoration:const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width:3,
                                color:Colors.black12
                            ),
                          ),
                          labelText: 'Phone',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: universityController,
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter university!';
                          }
                          return null;
                        },
                        decoration:const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width:3,
                                color:Colors.black12
                            ),
                          ),
                          labelText: 'University',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: facultyController,
                        keyboardType: TextInputType.name,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter faculty!';
                          }
                          return null;
                        },
                        decoration:const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width:3,
                                color:Colors.black12
                            ),
                          ),
                          labelText: 'Faculty',
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        //onChanged: (password) => onPasswordChanged(password),
                        controller: _password,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscureText,
                        validator: ( value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter password!';
                          }else {
                            bool result = validatePassword(value);
                            if(result){
                              return null ;
                            }else{
                              return "please enter strong password";
                            }
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder:const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width:3,
                                color:Colors.black12
                            ),
                          ),
                          labelText: 'password',
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                _obscureText = ! _obscureText;
                                isPassword = ! isPassword;
                              });
                            },
                            icon: isPassword ? Icon(Icons.visibility_off,
                              color: Colors.grey,
                            ) : Icon(Icons.visibility,
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
                        validator: ( value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter confirmpassword!';
                          }
                          if (_password.text != _confirmpassword.text)
                          {
                            return 'password dont match !';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          enabledBorder:const UnderlineInputBorder(
                            borderSide: BorderSide(
                                width:3,
                                color:Colors.black12
                            ),
                          ),
                          labelText: 'ConfirmPassword',
                          suffixIcon: IconButton(
                            onPressed: (){
                              setState(() {
                                _obscureText = ! _obscureText;
                                isPassword = ! isPassword;
                              });
                            },
                            icon: isPassword ? Icon(Icons.visibility_off,
                              color: Colors.grey,
                            ) : Icon(Icons.visibility,
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
                        color: pass_strength <=1/4 ? Color.fromRGBO(70, 121, 112, 1.0) : pass_strength == 2/4? Color.fromRGBO(70, 121, 112, 1.0) : pass_strength == 3/4 ? Color.fromRGBO(70, 121, 112, 1.0) : Color.fromRGBO(70, 121, 112, 1.0) ,

                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Row(
                      //   children: [
                      //     AnimatedContainer(
                      //       duration: Duration(milliseconds: 500),
                      //       width: 20,
                      //       height: 20,
                      //       decoration: BoxDecoration(
                      //         color: isPasswordEditingCharacter ? Colors.teal : Colors.transparent,
                      //         border: isPasswordEditingCharacter ?Border.all(color: Colors.transparent):
                      //         Border.all(color: Colors.grey.shade400),
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //       child: Center(
                      //         child: Icon(
                      //           Icons.check,
                      //           color: Colors.white,
                      //           size: 15,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //         "Contains at least 8 characters"
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // Row(
                      //   children: [
                      //     AnimatedContainer(
                      //       duration: Duration(milliseconds: 500),
                      //       width: 20,
                      //       height: 20,
                      //       decoration: BoxDecoration(
                      //         color: hasPasswordOneNumber ? Colors.teal : Colors.transparent,
                      //         border: hasPasswordOneNumber ?Border.all(color: Colors.transparent):
                      //         Border.all(color: Colors.grey.shade400),
                      //         borderRadius: BorderRadius.circular(50),
                      //       ),
                      //       child: Center(
                      //         child: Icon(
                      //           Icons.check,
                      //           color: Colors.white,
                      //           size: 15,
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 10,
                      //     ),
                      //     Text(
                      //         "Contains at least 1 number"
                      //     ),
                      //   ],
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),

                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:const Color.fromRGBO(70, 121, 112, 1.0),
                          ),
                          child: MaterialButton(
                            onPressed: ()async
                            {
                              if(formkey.currentState!.validate()){
                                cubit.userRegister(
                                    fullname:  nameController.text,
                                    email: emailController.text,
                                    // phone: numberController.text,
                                    university: universityController.text,
                                    faculty_id: facultyController.text,
                                    password: _password.text,
                                );
                              }else
                              {
                                print("******************************** llllllمدخلتش");
                              }
                            },
                            child:const Text(
                              'Sign Up',
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
                          const Text(
                            'Already have an account?',
                          ),
                          TextButton(
                            onPressed: ()
                            {
                              navigateTo(
                                context,
                                LoginScreen(),
                              );
                            },
                            child: const Text(
                              'Sign In',
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
            ),
          );
        },
      ),
    );
  }
}

