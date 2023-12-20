import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/chats/data/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/use_cases/get_messages_use_case.dart';
import 'package:graduation/features/chats/domain/use_cases/send_msessage_use_case.dart';
import 'package:graduation/features/chats/presentation/pages/chat_page/chat_state.dart';

class ChatsCubit extends Cubit<ChatState>
{
  ChatsCubit(this._getMessagesUseCase, this._sendMessageUseCase):super(const ChatState());
  final GetMessagesUseCase _getMessagesUseCase;
  final SendMessageUseCase _sendMessageUseCase;

  static ChatsCubit get(context)=>BlocProvider.of(context);

  void getMessages(String userId,String receiverId)
  {
    _getMessagesUseCase.call(userId, receiverId);
  }

  void sendMessage(ApiMessageModel message)
  {
    _sendMessageUseCase.call(message);
  }
}