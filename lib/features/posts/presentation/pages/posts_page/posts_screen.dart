import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';
import 'package:graduation/features/posts/presentation/pages/add_post_screen.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_cubit.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_states.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/widgets.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(),
      child: const PostPageBody(),
    );
  }
}

class PostPageBody extends StatefulWidget {
  const PostPageBody({Key? key}) : super(key: key);

  @override
  State<PostPageBody> createState() => _PostPageBodyState();
}

class _PostPageBodyState extends State<PostPageBody> {
  @override
  void initState() {
    PostsCubit.get(context).getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: ConditionalBuilder(
            condition: state.posts.isNotEmpty,
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        buildPostItem(state.posts[index], context),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.h,
                    ),
                    itemCount: state.posts.length,
                    //itemCount: 10,
                  ),
                ],
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigateTo(context, CreatePostPage());
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}

class PostButton extends StatelessWidget {
  const PostButton(
      {Key? key, required this.icon, required this.label, required this.onTap})
      : super(key: key);
  final ImageIcon icon;
  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: SizedBox(
            height: 25.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                SizedBox(
                  width: 4.0.w,
                ),
                Text(
                  label,
                  style: TextStyle(fontSize: 12.sp),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildPostItem(PostModel model, context) => Card(
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
