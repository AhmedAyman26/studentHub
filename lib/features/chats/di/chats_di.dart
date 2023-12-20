import 'package:get_it/get_it.dart';
import 'package:graduation/features/chats/data/repository/chats_repository_impl.dart';
import 'package:graduation/features/chats/domain/repository/chats_repository.dart';
import 'package:graduation/features/chats/domain/use_cases/get_messages_use_case.dart';
import 'package:graduation/features/chats/domain/use_cases/get_users_use_case.dart';
import 'package:graduation/features/chats/domain/use_cases/send_msessage_use_case.dart';

final injector = GetIt.instance;
class ChatsDi {
  static Future<void> init() async {
    // usecases

    injector.registerFactory(() => GetUsersUseCase(injector()));
    injector.registerFactory(() => GetMessagesUseCase(injector()));
    injector.registerFactory(() => SendMessageUseCase(injector()));
    // repository
    injector.registerLazySingleton<ChatsRepository>(() =>
        ChatsRepositoryImpl(
        ));
  }
}