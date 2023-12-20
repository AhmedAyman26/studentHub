import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/chats/data/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/repository/chats_repository.dart';

class SendMessageUseCase
{
  final ChatsRepository _chatsRepository;

  SendMessageUseCase(this._chatsRepository);

  Future<void>call(ApiMessageModel message)async
  {
    return await _chatsRepository.sendMessage(message);
  }
}