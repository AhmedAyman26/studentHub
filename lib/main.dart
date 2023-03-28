import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/bloc_observer.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/presentation/screens/Home.dart';
import 'package:graduation/presentation/screens/login/login_screen.dart';
import 'package:graduation/presentation/screens/register/register.dart';
import 'package:graduation/presentation/screens/test.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import 'package:graduation/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'presentation/screens/proucts/add_product_screen.dart';
import 'package:graduation/presentation/screens/onboarding/on_boarding_screen.dart';
bool isLogin=false;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  await DioHelper.init();
  Bloc.observer=MyBlocObserver();
  CacheHelper.init();

  // id= CacheHelper.getData(key: 'id');
  // if(id==null)
  // {
  //   isLogin=false;
  // }else
  // {
  //   isLogin=true;
  // }
  // print(isLogin.toString());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GraduationCubit(),
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
            home: HomeLayout(),
          );
        },
      ),
    );
  }
}

