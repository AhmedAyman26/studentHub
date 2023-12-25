import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/constants.dart';
import 'package:graduation/common/cubits/Language%20Cubit/language_cubit.dart';
import 'package:graduation/common/cubits/user_cubit/user_cubit.dart';
import 'package:graduation/common/cubits/user_cubit/user_state.dart';
import 'package:graduation/common/styles/colors.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/authentication/presentation/pages/login_page/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit, UserState>(
      listener: (context, state) {
        if (state.logout == RequestStatus.success) {
          navigateAndFinish(context, const LoginPage());
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            leading: Padding(
              padding: EdgeInsets.all(14.0.h),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(top: 12.0.h),
              child: Text(
                AppLocalizations.of(context)!.settings,
                style: TextStyle(color: Colors.black, fontSize: 18.sp),
              ),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(10.0.h),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: AppColors.kPrimaryColor,
                        radius: 25.w,
                        backgroundImage: NetworkImage(
                            UserCubit.get(context).state.userData?.image ??
                                '')),
                    SizedBox(
                      width: 15.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          UserCubit.get(context).state.userData?.fullName ?? '',
                          style: TextStyle(fontSize: 16.sp),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          UserCubit.get(context).state.userData?.facultyName ??
                              '',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          color: Colors.grey[600],
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16, left: 16),
                  child: ExpansionTile(
                    collapsedIconColor: Colors.black,
                    trailing: const Icon(Icons.arrow_drop_down_outlined),
                    iconColor: Colors.white,
                    title: Row(
                      children: [
                        const Icon(
                          Icons.language,
                          color: Colors.black,
                        ),
                        Text("   ${AppLocalizations.of(context)!.language}"),
                      ],
                    ),
                    childrenPadding: const EdgeInsets.all(5),
                    children: [
                      BlocBuilder<RadioListTileCubit, int>(
                          builder: (context, state) {
                        return Column(
                          children: [

                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(AppLocalizations.of(context)!.arabic),
                              activeColor:
                                  const Color.fromRGBO(70, 121, 112, 1.0),
                              value: 1,
                              groupValue: state,
                              onChanged: (value) {
                                context
                                    .read<RadioListTileCubit>()
                                    .selectItem(value!);
                                context
                                    .read<LanguageCubit>()
                                    .changeLanguage('ar');
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title:
                                  Text(AppLocalizations.of(context)!.english),
                              value: 0,
                              activeColor:
                                  const Color.fromRGBO(70, 121, 112, 1.0),
                              groupValue: state,
                              onChanged: (value) {
                                context
                                    .read<RadioListTileCubit>()
                                    .selectItem(value!);
                                context
                                    .read<LanguageCubit>()
                                    .changeLanguage('en');
                              },
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    UserCubit.get(context).logout('userData');
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 25.h,
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text(
                          'SignOut',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
