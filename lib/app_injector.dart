import 'package:get_it/get_it.dart';
import 'package:graduation/common/di/common_di.dart';
import 'package:graduation/features/authentication/di/authentication_di.dart';
import 'package:graduation/features/chats/di/chats_di.dart';
import 'package:graduation/features/posts/di/posts_di.dart';
import 'package:graduation/features/products/di/products_di.dart';
import 'package:graduation/features/services/di/services_di.dart';

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
  CommonDi.init();
  AuthenticationDi.init();
  PostsDi.init();
  ProductsDi.init();
  ServicesDi.init();
  ChatsDi.init();
}