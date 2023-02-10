import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/presentation/screens/Home.dart';
import 'package:graduation/presentation/screens/onboarding/onBoard.dart';
import 'package:graduation/presentation/screens/onboarding/on_boarding_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
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
        home:on_boarding_screen(),
      ),
    );
  }
}

