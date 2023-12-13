import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/features/posts/presentation/pages/add_post_screen.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_cubit.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_states.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/widgets/post_item.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/utils.dart';
import 'package:shimmer/shimmer.dart';

class PostPage extends StatelessWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit()..getPost(),
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
    // if(mounted) {
    //   PostsCubit.get(context).getPost();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<PostsCubit, PostStates>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.getPostState == RequestStatus.success) {
                  return ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) =>
                        PostItem(model: state.posts[index], context: context),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.h,
                    ),
                    itemCount: state.posts.length,
                  );
                }
                if (state.getPostState == RequestStatus.loading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.green,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.posts.length,
                      itemBuilder: (context, index) {
                        return const SizedBox(
                          height: 70,
                          child: Card(
                            color: Colors.green,
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('No internet connection'),
                        MaterialButton(
                            color: Colors.green,
                            child: const Text('Retry'),
                            onPressed: () {})
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // navigateTo(context, const CreatePostPage());
        },
        child: const Icon(Icons.add),
      ),
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
