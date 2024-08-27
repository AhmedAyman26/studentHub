import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/presentation/widgets/app_divider.dart';
import 'package:graduation/common/utils/constants/image_paths.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_page.dart';

class PostItem extends StatelessWidget {
  final PostModel post;
  final BuildContext context;

  const PostItem({super.key, required this.post, required this.context});

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
                Container(
                  height: 40,
                  width: 40,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent,
                  ),
                  child:CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: "${post.userImage}",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Image(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              'https://upload.wikimedia.org/wikipedia/commons/7/70/User_icon_BLACK-01.png'),
                        ),
                      ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    post.userName == null
                        ? const Text('name')
                        : Text(
                            '${post.userName}',
                          ),
                    post.postDate == null
                        ? const Text('12:00PM')
                        : Text('${post.postDate}'),
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
                '${post.text}',
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            post.postImage != ''
                ? Container(
                    height: 140,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(post.postImage ?? ''),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : const SizedBox(),
            const AppDivider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Row(
                children: [
                  PostButton(
                      icon: ImageIcon(
                        const AssetImage(ImagesPaths.like),
                        size: 22.w,
                        color: Colors.grey[600],
                      ),
                      label: 'React',
                      onTap: () {}),
                  PostButton(
                      icon: ImageIcon(
                        const AssetImage(ImagesPaths.comment),
                        size: 20.w,
                        color: Colors.grey[600],
                      ),
                      label: 'Comment',
                      onTap: () {}),
                  PostButton(
                      icon: ImageIcon(
                        const AssetImage(ImagesPaths.repost),
                        size: 20.w,
                        color: Colors.grey[600],
                      ),
                      label: 'Repost',
                      onTap: () {}),
                  PostButton(
                      icon: ImageIcon(
                        const AssetImage(ImagesPaths.send),
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
