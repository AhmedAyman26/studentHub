import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:graduation/common/presentation/widgets/app_text_form_field.dart';
import 'package:graduation/common/utils/constants/app_constants.dart';
import 'package:graduation/common/utils/constants/image_paths.dart';
import 'package:graduation/common/utils/styles/colors.dart';
import 'package:graduation/common/utils/utils.dart';
import 'package:graduation/features/Home.dart';
import 'package:graduation/features/authentication/domain/models/inputs/login_input.dart';
import 'package:graduation/features/authentication/presentation/pages/login_page/login_cubit.dart';
import 'package:graduation/features/authentication/presentation/pages/login_page/login_state.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const LoginPageBody(),
    );
  }
}

class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  bool _obscureText = true;

  bool? isChecked = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.loginState == RequestStatus.success) {
            UserCubit.get(context).cacheUser(state.userData);
            navigateAndFinish(context, const HomeLayout());
          }
          if(state.loginState==RequestStatus.error)
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                      width: double.infinity,
                      child: Image(
                        image: AssetImage(ImagesPaths.loginHeader),
                        fit: BoxFit.fill,
                      )),
                  Center(
                    child: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            children: [
                              AppTextFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                hintText: 'Email',
                              ),
                              SizedBox(height: 20.0.h),
                              AppTextFormField(
                                obscureText: _obscureText,
                                hintText: 'Password',
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    color: Colors.black12,
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    semanticLabel: _obscureText
                                        ? AppLocalizations.of(context)!
                                            .show_password
                                        : AppLocalizations.of(context)!
                                            .hide_password,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Row(
                                children: [
                                  Checkbox(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      activeColor: AppColors.kPrimaryColor,
                                      value: isChecked,
                                      onChanged: (bool? value) {
                                        isChecked = value;
                                        setState(() {});
                                      }),
                                  Text(
                                    AppLocalizations.of(context)!.remember_me,
                                    style: const TextStyle(
                                        color: Colors.black54, fontSize: 15),
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0.h),
                              ConditionalBuilder(
                                condition:
                                    state.loginState != RequestStatus.loading,
                                builder: (context) => Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16.0),
                                  child: ButtonTheme(
                                    buttonColor: AppColors.kPrimaryColor,
                                    minWidth: 250.0,
                                    height: 50.0,
                                    child: MaterialButton(
                                      color: AppColors.kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      onPressed: () {
                                        LoginCubit.get(context).login(
                                            LoginInput(emailController.text,
                                                passwordController.text));
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.sign_in,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 21),
                                      ),
                                    ),
                                  ),
                                ),
                                fallback: (context) =>
                                    const CircularProgressIndicator(),
                              ),
                              TextButton(
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .forgot_password,
                                    style:
                                        const TextStyle(color: Colors.black54),
                                  ),
                                  onPressed: () {}),
                              TextButton(
                                onPressed: () {
                                  navigateAndFinish(
                                      context, const RegisterPage());
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.not_member,
                                  style: const TextStyle(color: Colors.black54),
                                ),
                              ),
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
}
