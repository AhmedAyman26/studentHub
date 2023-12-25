import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/widgets/widgets.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_screen.dart';

class PostItem extends StatelessWidget {
  final PostModel model;
  final BuildContext context;
  const PostItem({super.key, required this.model, required this.context});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.grey[500]!, width: 2.w),
        borderRadius: BorderRadius.circular(
          20,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 20,
                  child: Image(
                    fit: BoxFit.cover,
                    image: model.userImage?.isEmpty == true ||
                        model.userImage?.isNotEmpty == true
                        ? const NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png')
                        : NetworkImage(model.userImage ?? ''),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    model.userName == null
                        ? const Text('name')
                        : Text(
                      '${model.userName}',
                    ),
                    model.postDate == null
                        ? const Text('12:00PM')
                        : Text('${model.postDate}'),
                  ],
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text('+ Follow'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${model.text}',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            model.postImage != ''
                ? Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage('${model.postImage}'
                    //
                  ),
                  fit: BoxFit.fill,
                ),
              ),
            )
                : const SizedBox(),
            myDivider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Row(
                children: [
                  PostButton(
                      icon: ImageIcon(
                        const AssetImage("assets/images/like.png"),
                        size: 22.w,
                        color: Colors.grey[600],
                      ),
                      label: 'React',
                      onTap: () {
                        print(model.postImage);
                      }),
                  PostButton(
                      icon: ImageIcon(
                        const AssetImage("assets/images/comment.png"),
                        size: 20.w,
                        color: Colors.grey[600],
                      ),
                      label: 'Comment',
                      onTap: () {}),
                  PostButton(
                      icon: ImageIcon(
                        const AssetImage("assets/images/repost.png"),
                        size: 20.w,
                        color: Colors.grey[600],
                      ),
                      label: 'Repost',
                      onTap: () {}),
                  PostButton(
                      icon: ImageIcon(
                        const AssetImage("assets/images/send.png"),
                        size: 20.w,
                        color: Colors.grey[600],
                      ),
                      label: 'Send',
                      onTap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
