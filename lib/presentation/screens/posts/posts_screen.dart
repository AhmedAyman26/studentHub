import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children:
          [
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context,index)=>buildPostItem(context),
          // (context,index)=>buildPostItem(SocialCubit.get(context).posts[index],context,index)
          separatorBuilder: (context,index)=>const SizedBox(height: 10,),
          itemCount: 10,
        )
          ],
        ),
      ),
    );
  }
  // Widget buildPostItem(PostModel model,context,index)
  Widget buildPostItem(context)=>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5,
    margin: const EdgeInsets.all(6),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Row(
            children:
            [
              CircleAvatar(
                radius: 25,
                child: Icon(
                  Icons.person
                ),
                // backgroundImage: NetworkImage(
                //     // '${model.image}'
                //   ''
                // ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                  [
                    Row(
                      children: [
                        Text(
                          // '${model.username}',
                          'AhmedAyman',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.lightBlue,
                          size: 15,
                        ),
                      ],
                    ),
                    Text(
                      // '${model.dateTime}',
                     '20-12-2022',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              IconButton(
                onPressed: (){},
                icon: const Icon(Icons.more_horiz,
                  size: 16,),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 15
            ),
            child: Container(
              height: 1,
              color: Colors.grey,
              width: double.infinity,
            ),
          ),
          Text(
            // '${model.text}',
              'I cant found my wallet...if any one found it please tell me',
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 1.3
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //       bottom: 10,
          //       top: 5
          //   ),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children:
          //       [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //               end: 6
          //           ),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                   '#software',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: Colors.lightBlue
          //                   )
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(
          //               end: 6
          //           ),
          //           child: Container(
          //             height: 25,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                   '#flutter',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                       color: Colors.lightBlue
          //                   )
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          // if(model.postImage!='')
          //   Padding(
          //     padding: const EdgeInsets.only(top: 15),
          //     child: Container(
          //       height: 140,
          //       width: double.infinity,
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(4),
          //         image: DecorationImage(
          //             image: NetworkImage(
          //                 // '${model.postImage}
          //               '',
          //             ),
          //             fit: BoxFit.cover
          //         ),
          //       ),
          //     ),
          //   ),
          Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 5
            ),
            child: Row(
              children:
              [
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.heart_broken_outlined,
                            size: 16,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            // '${SocialCubit.get(context).likes[index]}',
                            '5',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.chat_outlined,
                            size: 16,
                            color: Colors.amber,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '0 comment',
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                    onTap: (){},
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                bottom: 10
            ),
            child: Container(
              height: 1,
              color: Colors.grey,
              width: double.infinity,
            ),
          ),
          Row(
            children:
            [
              Expanded(
                child: InkWell(
                  child: Row(
                    children:
                    [
                      CircleAvatar(
                        child: Icon(
                          Icons.person
                        ),
                        radius: 15,
                        // backgroundImage: NetworkImage(
                        //     '${SocialCubit.get(context).userModel!.image}'
                        // ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Write a comment....',
                        style: Theme.of(context).textTheme.caption!.copyWith(
                            fontSize: 13
                        ),
                      ),
                    ],
                  ),
                  onTap: ()
                  {
                    // navigateTo(context, CommentScreen());
                  },
                ),
              ),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      Icons.heart_broken_outlined,
                      size: 16,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: ()
                {
                  // SocialCubit.get(context).likePost(SocialCubit.get(context).postsId[index]);
                },
              ),

            ],
          )
        ],
      ),
    ),
  );
}
