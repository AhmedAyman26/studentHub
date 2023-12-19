import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/features/authentication/presentation/pages/login_page/login_page.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_cubit.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/register_state.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/widgets/register_header.dart';
import 'package:graduation/features/authentication/presentation/pages/register_page/widgets/registeration_form.dart';
import 'package:graduation/presentation/screens/home.dart';
import 'package:graduation/shared/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation/shared/cubits/user_cubit/user_cubit.dart';
import 'package:graduation/shared/utils.dart';
import 'package:graduation/shared/widgets.dart';

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


  String? profileImageLink;
  @override
  void initState() {
    RegisterCubit.get(context).getUniversities();
    RegisterCubit.get(context).getFaculties();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) async {
        if (state.registerState == RequestStatus.success) {
          UserCubit.get(context).cacheUser(state.userData);
          navigateAndFinish(
            context,
            const HomeLayout(),
          );
        }
      },
      builder: (context, state) {
        if (state.faculties.isNotEmpty || state.universities.isNotEmpty) {
          return Scaffold(
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  const RegisterHeader(),
                  SizedBox(
                    height: 20.h,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                         showSelectImageBottomSheet(context,
                                (image)async
                            {
                              await FirebaseStorage.instance
                                  .ref()
                                  .child(
                                  'users/${Uri.file(image.path).pathSegments.last}')
                                  .putFile(image)
                                  .then((value) {
                                value.ref.getDownloadURL().then((value) {
                                  profileImageLink = value;
                                  setState(() {
                                  });
                                });
                              });
                              Navigator.of(context).pop();
                            }
                        );
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
                                fontSize: 14.sp, color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                      bottom: 15.h,
                      left: 50.w,
                      right: 50.w,
                    ),
                    child:  RegistrationForm(
                      profileImageLink: profileImageLink??'',
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
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
                            const LoginPage(),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.sign_in,
                          style: const TextStyle(
                            color: Color.fromRGBO(70, 121, 112, 1.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
