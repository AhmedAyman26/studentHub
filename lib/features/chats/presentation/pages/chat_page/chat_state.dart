import 'package:equatable/equatable.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/chats/domain/models/api_message_model.dart';

class ChatState extends Equatable {
  final RequestStatus? messagesState;
  final Stream<List<MessageModel>>? messages;
  final RequestStatus? sendMessageState;

  const ChatState({this.messagesState, this.messages, this.sendMessageState});


  ChatState copyWith({
    RequestStatus? messagesState,
    Stream<List<MessageModel>>? messages,
    RequestStatus? sendMessageState,
  }) {
    return ChatState(
        messagesState: messagesState ?? this.messagesState,
        messages: messages ?? this.messages,
      sendMessageState: sendMessageState??this.sendMessageState
    );
  }

  @override
  List<Object?> get props => [messages,messagesState,sendMessageState];
}
