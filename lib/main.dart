import 'dart:convert';
import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/bloc_observer.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/features/posts/di/posts_di.dart';
import 'package:graduation/logic/Language%20Cubit/language_cubit.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/presentation/screens/home.dart';
import 'package:graduation/presentation/screens/login/login_screen.dart';
import 'package:graduation/presentation/screens/register/register.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import 'package:graduation/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'logic/Language Cubit/language_states.dart';
import 'presentation/screens/proucts/add_product_screen.dart';
import 'package:graduation/presentation/screens/onboarding/on_boarding_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
bool isLogin=false;
void main()async {

  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp();
  await DioHelper.init();
  Bloc.observer=MyBlocObserver();
  await CacheHelper.init();


  Widget widget;
  var onBoarding=CacheHelper.getData(key: 'onBoarding');
  var id=CacheHelper.getData(key: 'uId');

  if(onBoarding !=null)
  {
    if(id !=null)
    {
      widget=HomeLayout();
    }else
    {
      widget=LoginScreen();
    }
  }else
  {
    widget=OnBoardingScreen();
  }
  // id= CacheHelper.getData(key: 'id');
  // if(id==null)
  // {
  //   isLogin=false;
  // }else
  // {
  //   isLogin=true;
  // }
  // print(isLogin.toString());
  runApp(MyApp(startWidget: widget,));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
        providers: [
          // BlocProvider(
          //   create: (context) => GraduationCubit()..getUserData()..getSubj(1),
          // ),
          BlocProvider<LanguageCubit>(
            create: (BuildContext context) => LanguageCubit()..getSavedLanguage(),
          ),
          BlocProvider<RadioListTileCubit>(
            create: (BuildContext context) => RadioListTileCubit(),
          ),
        ],
        child: BlocBuilder<LanguageCubit,languageStates>(
        builder: (context,state) {
          if (state is changeLanguageState) {
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (context, child) {
                return MaterialApp(
                  localizationsDelegates: [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: AppLocalizations.supportedLocales,
                  locale: state.locale,
                  theme: ThemeData(
                      primaryColor: Colors.teal,
                      primarySwatch: Colors.teal
                  ),
                  debugShowCheckedModeBanner: false,
                  home:startWidget,
                );
              },
           );
          }else{
          return const SizedBox();
          }
        },
    ),
    );
  }
}

