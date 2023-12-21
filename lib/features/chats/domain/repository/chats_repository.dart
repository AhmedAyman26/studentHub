import 'package:graduation/features/chats/data/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/models/api_message_model.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';

abstract class ChatsRepository
{
  Future<List<UserData>> getUsers();
  Stream<List<MessageModel>> getMessages(String userId,String receiverId);
  Future<void> sendMessage(ApiMessageModel message);
}