import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/app.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/bloc_observer.dart';
import 'package:graduation/common/local/cache_helper.dart';
import 'package:graduation/common/web_services/dio_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp();
  await DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  runApp(const StudentHubApp());
}
