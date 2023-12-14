import 'package:get_it/get_it.dart';
import 'package:graduation/features/authentication/di/authentication_di.dart';
import 'package:graduation/features/posts/di/posts_di.dart';

final injector = GetIt.instance;

Future<void> initializeDependencies() async {

  injector.pushNewScope();
  await registerAppDependencies();
}
//TODO:use this func with AuthLogout func to resetScope.
Future<void> resetScopeDependencies() async {
  await injector.resetScope();
  await registerAppDependencies();
}

Future<void> registerAppDependencies() async {
  AuthenticationDi.init();
  PostsDi.init();
}