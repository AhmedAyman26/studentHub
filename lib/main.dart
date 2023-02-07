import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/presentation/screens/Home.dart';
import 'package:graduation/presentation/screens/login/login_screen.dart';
import 'package:graduation/presentation/screens/onboarding/on_boarding_screen.dart';
import 'package:graduation/presentation/screens/register/register.dart';
import 'package:graduation/presentation/screens/test.dart';
import 'package:graduation/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

import 'presentation/screens/proucts/add_product_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GraduationCubit(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.teal,
          primarySwatch: Colors.teal
        ),
        debugShowCheckedModeBanner: false,
        home: tabs(),
      ),
    );
  }
}

