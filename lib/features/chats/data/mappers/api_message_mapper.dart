import 'package:graduation/features/chats/data/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/models/api_message_model.dart';

extension ApiMessageMapper on ApiMessageModel
{
  MessageModel map()
  {
    return MessageModel(
      image: image??'',
      text: text??'',
      dateTime: dateTime??'',
      receiverId: receiverId??'',
      senderId: senderId??''
    );
  }
}