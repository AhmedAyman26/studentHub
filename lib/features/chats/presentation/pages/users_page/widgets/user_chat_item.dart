import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/constants.dart';
import 'package:graduation/features/authentication/domain/models/user_model.dart';
import 'package:graduation/features/chats/presentation/pages/chat_page/chat_screen.dart';

class UserChatItem extends StatelessWidget {
  final UserData user;
  const UserChatItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {

        navigateTo(context, ChatPage(
          user: user,
        ));
      },
      child: Row(
        children: [
          CircleAvatar(
              radius: 20.h,
              backgroundImage: (user.image != ""||user.image!=null)
                  ? NetworkImage('${user.image}')
                  : const NetworkImage(
                  'https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png')),
          SizedBox(
            width: 15.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.fullName}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 5.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
