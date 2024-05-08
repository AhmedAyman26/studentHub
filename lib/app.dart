import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:graduation/common/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:graduation/common/presentation/cubits/language_cubit/language_states.dart';
import 'package:graduation/common/presentation/cubits/user_cubit/user_cubit.dart';
import 'package:graduation/common/presentation/cubits/user_cubit/user_state.dart';
import 'package:graduation/common/utils/utils.dart';
import 'package:graduation/features/Home.dart';
import 'package:graduation/features/authentication/presentation/pages/login_page/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StudentHubApp extends StatelessWidget {
  const StudentHubApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserCubit()..getCachedUserData(),
        ),
        BlocProvider<LanguageCubit>(
          create: (BuildContext context) => LanguageCubit()..getSavedLanguage(),
        ),
        BlocProvider<RadioListTileCubit>(
          create: (BuildContext context) => RadioListTileCubit(),
        ),
      ],
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          if (state is ChangeLanguageState) {
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: state.locale,
                  theme: ThemeData(
                    useMaterial3: false,
                      primaryColor: Colors.teal, primarySwatch: Colors.teal),
                  debugShowCheckedModeBanner: false,
                  home: BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                    if (state.userDataState == RequestStatus.loading) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      if (state.userData != null) {
                        return const HomeLayout();
                      } else {
                        return const LoginPage();
                      }
                    }
                  }),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
