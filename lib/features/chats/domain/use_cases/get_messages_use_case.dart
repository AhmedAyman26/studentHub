import 'package:graduation/features/chats/domain/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/repository/chats_repository.dart';

class GetMessagesUseCase
{
  final ChatsRepository _chatsRepository;

  GetMessagesUseCase(this._chatsRepository);

  Future<List<MessageModel>> call(String userId,String receiverId)
  {
    return _chatsRepository.getMessages(userId, receiverId);
  }
}