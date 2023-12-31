import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:graduation/features/chats/data/mappers/api_message_mapper.dart';
import 'package:graduation/features/chats/data/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/models/api_message_model.dart';
import 'package:graduation/features/authentication/data/mapper/api_user_data_mapper.dart';
import 'package:graduation/features/authentication/data/models/api_user_model.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/chats/domain/repository/chats_repository.dart';

class ChatsRepositoryImpl extends ChatsRepository {
  @override
  Future<List<UserData>> getUsers() async {
    List<UserData> users = [];

    await FirebaseFirestore.instance.collection(
        'users').get().then((value) {
          for (var element in value.docs) {
            users.add(ApiUserData.fromJson(element.data()).map());
          }
    });    return users;
  }

  @override
  Stream<List<MessageModel>> getMessages(String userId,String receiverId) {
         return FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .orderBy('dateTime')
          .snapshots().map((event) {
            return event.docs.map((e) {
              return   ApiMessageModel.fromJson(e.data()).map();
            },).toList();
          },);
    }

  @override
  Future<void> sendMessage(ApiMessageModel message)async {

      await FirebaseFirestore.instance
          .collection('users')
          .doc(message.senderId)
          .collection('chats')
          .doc(message.receiverId)
          .collection('messages')
          .add(message.toMap())
          .then((value){
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(message.receiverId)
          .collection('chats')
          .doc(message.senderId)
          .collection('messages')
          .add(message.toMap())
          .then((value){
      });
  }
}