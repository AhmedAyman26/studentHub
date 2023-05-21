import 'dart:convert';

import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/bloc_observer.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/presentation/screens/home.dart';
import 'package:graduation/presentation/screens/login/login_screen.dart';
import 'package:graduation/presentation/screens/posts/posts_screen.dart';
import 'package:graduation/presentation/screens/register/register.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import 'package:graduation/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'presentation/screens/proucts/add_product_screen.dart';
import 'package:graduation/presentation/screens/onboarding/on_boarding_screen.dart';
bool isLogin=false;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await DioHelper.init();
  Bloc.observer=MyBlocObserver();
  await CacheHelper.init();


  Widget widget;
  bool onBoarding=CacheHelper.getData(key: 'onBoarding');
  String id=CacheHelper.getData(key: 'id');
  print(onBoarding);

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

    return BlocProvider(
      create: (context) => GraduationCubit()..getUserData()..getPost(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context,child)
        {
          return MaterialApp(
            theme: ThemeData(
                primaryColor: Colors.teal,
                primarySwatch: Colors.teal
            ),
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}

