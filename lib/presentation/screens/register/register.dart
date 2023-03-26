import 'package:conditional_builder/conditional_builder.dart';
import 'package:dio/dio.dart';
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



class RegisterScreen extends StatelessWidget {

  var formKey = GlobalKey<FormState>();
  var nameController =TextEditingController();
  var emailController =TextEditingController();
  var universityController =TextEditingController();
  var facultyController =TextEditingController();
  var numberController =TextEditingController();
  var passwordController =TextEditingController();
  var confirmController =TextEditingController();

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
                preferredSize: Size(double.infinity,150),
                child: ClipPath(
                  clipper: CustomAppBarShape(),
                  child: Container(
                    color: kPrimaryColor,
                  ),
                ),
              ),
            body: Padding(
              padding: const EdgeInsets.all(50),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                        },
                        decoration:const InputDecoration(
                          labelText: 'Full Name',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter email address!';
                          }
                        },
                        decoration:const InputDecoration(
                          labelText: 'Email',
                          // prefixIcon: Icon(
                          //   Icons.email,
                          // ),
                          border: UnderlineInputBorder(),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: numberController,
                        keyboardType: TextInputType.number,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter phone number!';
                          }
                        },
                        decoration:const InputDecoration(
                          labelText: 'Phone Number',
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                        },
                        decoration:const InputDecoration(
                          labelText: 'University',
                          border: UnderlineInputBorder(),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
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
                        },
                        decoration:const InputDecoration(
                          labelText: 'Faculty',
                          border: UnderlineInputBorder(),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter password!';
                          }
                        },
                        obscureText: true,
                        decoration:const InputDecoration(
                          labelText: 'Password',
                          suffixIcon: Icon(
                              Icons.visibility_outlined
                          ),
                          border: UnderlineInputBorder(),

                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: confirmController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        validator: (value)
                        {
                          if (value!.isEmpty)
                          {
                            return 'please enter confirm password!';
                          }
                        },
                        decoration:const InputDecoration(
                          labelText: 'Confirm Password',
                          suffixIcon: Icon(
                              Icons.remove_red_eye
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color:const Color.fromRGBO(70, 121, 112, 1.0),
                          ),
                          child: MaterialButton(
                            onPressed: ()async
                            {
                              if(formKey.currentState!.validate()){
                                cubit.userRegister(
                                    fullname:  nameController.text,
                                    email: emailController.text,
                                    // phone: numberController.text,
                                    university: universityController.text,
                                    faculty_id: facultyController.text,
                                    password: passwordController.text,
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

