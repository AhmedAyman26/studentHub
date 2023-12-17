import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/features/authentication/domain/models/inputs/register_input.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_cubit.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_state.dart';
import 'package:graduation/shared/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegistrationForm extends StatefulWidget {
  final String profileImageLink;

  const RegistrationForm({super.key, required this.profileImageLink});

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  late int facultyId;
  late int universityId;
  double passStrength = 0;
  bool _passwordObscured = true;
  bool _confirmPasswordObscured = true;
  RegExp passwordValidator = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  bool validatePassword(String pass) {
    String password = pass.trim();
    if (password.isEmpty) {
      setState(() {
        passStrength = 0;
      });
    } else if (password.length < 6) {
      setState(() {
        passStrength = 1 / 4;
      });
    } else if (password.length < 8) {
      setState(() {
        passStrength = 2 / 4;
      });
    } else {
      if (passwordValidator.hasMatch(password)) {
        setState(() {
          passStrength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          passStrength = 3 / 4;
        });
        return false;
      }
    }
    return false;
  }

  String? selectedUniversity;
  String? selectedFaculty;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Form(
            key: formKey,
            child: Column(
              children: [
                AppTextFormField(
                  controller: nameController,
                  type: TextInputType.name,
                  label: AppLocalizations.of(context)!.full_name,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.enter_name;
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 15.h,
                ),
                AppTextFormField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? AppLocalizations.of(context)!.enter_email
                          : null,
                  label: AppLocalizations.of(context)!.email,
                ),
                SizedBox(
                  height: 15.h,
                ),
                AppTextFormField(
                  controller: phoneController,
                  type: TextInputType.number,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.enter_phon;
                    }
                    if (value.length < 10) {
                      return AppLocalizations.of(context)!.enter_vphon;
                    }
                    return null;
                  },
                  label: AppLocalizations.of(context)!.phone,
                ),
                const SizedBox(
                  height: 15,
                ),
                DropdownButton(
                  items: state.universities
                      .map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  onChanged: (e) {
                    selectedUniversity = e;
                    universityId = state.universities.indexOf(e ?? '') + 1;
                    setState(() {});
                  },
                  isExpanded: true,
                  hint: Text(AppLocalizations.of(context)!.select_university),
                  value: selectedUniversity,
                ),
                SizedBox(
                  height: 15.h,
                ),
                DropdownButton(
                    items: state.faculties
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (e) {
                      selectedFaculty = e;
                      facultyId = state.faculties.indexOf(e ?? '') + 1;
                      setState(() {});
                    },
                    isExpanded: true,
                    hint: const Text('select Your faculty'),
                    value: selectedFaculty),
                SizedBox(
                  height: 15.h,
                ),
                AppTextFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  validate: (value) {
                    if (value!.isEmpty) {
                      return AppLocalizations.of(context)!.enter_password;
                    } else {
                      bool result = validatePassword(value);
                      if (!result) {
                        return AppLocalizations.of(context)!.strong_pass;
                      }
                    }
                  },
                  obscureText: _passwordObscured,
                  label: AppLocalizations.of(context)!.password,
                  suffix: IconButton(
                      icon: Icon(
                        _passwordObscured
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordObscured = !_passwordObscured;
                        });
                      }),
                ),
                SizedBox(
                  height: 15.h,
                ),
                AppTextFormField(
                    obscureText: _confirmPasswordObscured,
                    suffix: IconButton(
                        icon: Icon(
                          _confirmPasswordObscured
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _confirmPasswordObscured =
                                !_confirmPasswordObscured;
                          });
                        }),
                    controller: confirmPasswordController,
                    type: TextInputType.visiblePassword,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return AppLocalizations.of(context)!.enter_cpassword;
                      }
                      if (passwordController.text !=
                          confirmPasswordController.text) {
                        return AppLocalizations.of(context)!.pass_notmatch;
                      }
                      return null;
                    },
                    label: AppLocalizations.of(context)!.confirm_password),
                SizedBox(
                  height: 30.h,
                ),
                LinearProgressIndicator(
                  value: passStrength,
                  backgroundColor: Colors.black12,
                  minHeight: 5,
                  color: passStrength <= 1 / 4
                      ? const Color.fromRGBO(70, 121, 112, 1.0)
                      : passStrength == 2 / 4
                          ? const Color.fromRGBO(70, 121, 112, 1.0)
                          : passStrength == 3 / 4
                              ? const Color.fromRGBO(70, 121, 112, 1.0)
                              : const Color.fromRGBO(70, 121, 112, 1.0),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(70, 121, 112, 1.0),
                    ),
                    child: MaterialButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          RegisterCubit.get(context).registerUser(
                            RegisterInput(
                                nameController.text.trim(),
                                emailController.text.trim(),
                                passwordController.text.trim(),
                                universityId.toString(),
                                facultyId.toString(),
                                widget.profileImageLink),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Center(child: Text('please try again')),
                            backgroundColor: Colors.red,
                          ));
                        }
                      },
                      child: Text(
                        AppLocalizations.of(context)!.sign_up,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          //fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
