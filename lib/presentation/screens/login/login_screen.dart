import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_page.dart';
import 'package:graduation/logic/login_cubit/cubit.dart';
import 'package:graduation/logic/login_cubit/states.dart';
import 'package:graduation/presentation/screens/login/forget_password_screen.dart';
import 'package:graduation/presentation/screens/home.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import 'package:graduation/shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static String tag = 'login-page';


  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  GlobalKey<FormState> _key = new GlobalKey();

  bool _validate = false;

  bool _obscureText = true;

  bool? check1 = false;

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>
        (
        listener: (context, state) {
          if (state is LoginSuccessState) {
            CacheHelper.saveData(
              key: 'uId',
              value: state.uId,
            ).then((value) {
              navigateAndFinish(context, HomeLayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      width: double.infinity,
                      child: Image(
                        image: AssetImage('assets/images/signin.png'),
                        fit: BoxFit.fill,)),
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            children: [
                              //SizedBox(height: 50.0),
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.black12),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black12)),
                                  hintText: AppLocalizations.of(context)!.email,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 15.0, 20.0, 15.0),

                                ),

                              ),
                              SizedBox(height: 20.0),
                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                obscureText: _obscureText,

                                decoration: InputDecoration(
                                  hintText: AppLocalizations.of(context)!.password,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 3, color: Colors.black12),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black12)),
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      // setState(() {
                                      //   _obscureText = !_obscureText;
                                      // });
                                    },
                                    child: Icon(
                                      color: Colors.black12,
                                      _obscureText ? Icons.visibility : Icons
                                          .visibility_off,
                                      semanticLabel:
                                      _obscureText
                                          ? AppLocalizations.of(context)!.show_password
                                          : AppLocalizations.of(context)!.hide_password,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.0),
                              Row(
                                children: [
                                  Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      activeColor: kPrimaryColor,
                                      value: check1,
                                      onChanged: (bool? value) {
                                        // setState(() {
                                        //   check1 = value;
                                        // });
                                      }
                                  ),
                                  Text(AppLocalizations.of(context)!.remember_me,
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0.h),
                              ConditionalBuilder(
                                condition: state is !LoginLoadingState,
                                builder: (context) =>
                                    Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16.0),
                                        child: ButtonTheme(
                                          buttonColor: kPrimaryColor,
                                          minWidth: 250.0,
                                          height: 50.0,
                                          child: MaterialButton(
                                            color: kPrimaryColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(18),
                                            ),
                                            onPressed: () {
                                              LoginCubit.get(context).userLogin(
                                                  email: emailController.text
                                                      .trim(),
                                                  password: passwordController
                                                      .text.trim(),
                                                  context: context);
                                            },
                                            child: Text(AppLocalizations.of(context)!.sign_in,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 21),
                                            ),
                                          ),
                                        )
                                    ),
                                fallback: (context) =>
                                    CircularProgressIndicator(),
                              ),
                              TextButton(
                                child: Text(
                                 AppLocalizations.of(context)!.forgot_password,
                                  style: TextStyle(color: Colors.black54),
                                ),
                                onPressed: () {
                                  navigateTo(context, ForgetPasswordScreen());
                                },
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateAndFinish(
                                        context, const RegisterPage());
                                  },
                                  child: Text(AppLocalizations.of(context)!.not_member,
                                      style: TextStyle(color: Colors.black54))),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<Null> _showForgotPasswordDialog(context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title:  Text(AppLocalizations.of(context)!.enter_email),
            contentPadding: EdgeInsets.all(5.0),
            content: new TextField(
              decoration: new InputDecoration(hintText:AppLocalizations.of(context)!.email),

            ),
            actions: <Widget>[
              new TextButton(
                child: new Text(AppLocalizations.of(context)!.ok),
                onPressed: () async {

                  Navigator.pop(context);
                },
              ),

            ],
          );
        });
  }
}
