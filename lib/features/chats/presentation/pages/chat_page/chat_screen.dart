import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/features/chats/data/models/api_message_model.dart';
import 'package:graduation/features/chats/domain/models/api_message_model.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/chats/presentation/pages/chat_page/chat_cubit.dart';
import 'package:graduation/features/chats/presentation/pages/chat_page/chat_state.dart';
import 'package:graduation/features/chats/presentation/pages/chat_page/widgets/select_attachment_bottom_sheet.dart';
import 'package:graduation/shared/cubits/user_cubit/user_cubit.dart';

class ChatPage extends StatelessWidget {
  final UserData user;

  const ChatPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsCubit(injector(), injector()),
      child: ChatScreen(
        user: user,
      ),
    );
  }
}

class ChatScreen extends StatefulWidget {
  final UserData user;

  const ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    ChatsCubit.get(context).getMessages(
        userId: UserCubit.get(context).state.userData?.firebaseId ?? '',
        receiverId: widget.user.firebaseId ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return BlocConsumer<ChatsCubit, ChatState>(
      listener: (context, state) {
        log("${state.messages}");
      },
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  const Image(
                    image: AssetImage('assets/images/chatHeader.png'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20.h, left: 10.w),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  size: 25.w,
                                  color: Colors.white,
                                )),
                            CircleAvatar(
                                radius: 25,
                                backgroundImage: widget.user.image != null
                                    ? NetworkImage('${widget.user.image}')
                                    : const NetworkImage(
                                        'https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png')),
                            SizedBox(
                              width: 8.w,
                            ),
                            Text(
                              '${widget.user.fullName}',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 25.w,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.more_vert_rounded,
                                  size: 25.w,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: (state.messages?.length != 0),
                  builder: (context) => Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: StreamBuilder(
                            stream: state.messages,
                            builder: (context, snapshot) {
                              return ListView.separated(
                                itemBuilder: (context, index) {
                                  if (UserCubit.get(context).state.userData?.firebaseId ==
                                      snapshot.data?[index].senderId) {
                                    return buildMyMessage(
                                        snapshot.data![index]);
                                  }
                                  return buildMessage(snapshot.data![index]);
                                },
                                shrinkWrap: true,
                                separatorBuilder: (context, state) => SizedBox(
                                  height: 15.h,
                                ),
                                itemCount: snapshot.data?.length ?? 0,
                              );
                            }),
                      ),
                    ],
                  ),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: TextFormField(
                          controller: messageController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          cursorColor: const Color.fromRGBO(70, 121, 112, 1.0),
                          maxLines: 5,
                          minLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write a message..',
                            prefixIcon: IconButton(
                              color: const Color.fromRGBO(70, 121, 112, 1.0),
                              icon: const Icon(
                                Icons.emoji_emotions_outlined,
                              ),
                              onPressed: () {},
                            ),
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        context: context,
                                        builder: (builder) =>
                                            const SelectAttachmentBottomSheet());
                                  },
                                  icon: const Icon(
                                    Icons.attach_file,
                                  ),
                                  color:
                                      const Color.fromRGBO(70, 121, 112, 1.0),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt,
                                  ),
                                  color:
                                      const Color.fromRGBO(70, 121, 112, 1.0),
                                ),
                              ],
                            ),
                            contentPadding: const EdgeInsets.all(5),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        left: 2,
                        right: 5,
                      ),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor:
                            const Color.fromRGBO(70, 121, 112, 1.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            if (messageController.text.isNotEmpty) {
                              ChatsCubit.get(context)
                                  .sendMessage(ApiMessageModel(
                                senderId: UserCubit.get(context)
                                        .state
                                        .userData
                                        ?.firebaseId ??
                                    '',
                                receiverId: widget.user.firebaseId,
                                dateTime: DateTime.now().toString(),
                                text: messageController.text,
                              ));
                              messageController.clear();
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMessage(MessageModel message) {
    print("@@@@@@@@@@@@@@@@@@@@@@@@${message.image}");
    return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 10,
            ),
            child:
                Column(
                  children: [
                    (message.image==null || message.image=='')?SizedBox.shrink():Image(image: NetworkImage(message.image??'')),
                    Text(
                      message.text ?? '',
            ),
                  ],
                )),
      );
  }

  Widget buildMyMessage(MessageModel message) {
    print("@@@@@@@@@@@@@@@@@@@@@@@@${message.image}");
    return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: const BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child:
          Column(
            children: [
              (message.image==null || message.image=='')?const SizedBox.shrink():Image(image: NetworkImage(message.image??'')),
              Text(
                message.text ?? '',
              ),
            ],
          )
        ),
      );
  }
}
