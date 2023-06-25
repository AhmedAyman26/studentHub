import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/data/models/post_model.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:graduation/presentation/screens/posts/add_post_screen.dart';
import 'package:graduation/presentation/widgets/search_widget.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/widgets.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GraduationCubit,GraduationStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          body: ConditionalBuilder(
            condition: GraduationCubit.get(context).posts.length >1,
            builder: (context) => SingleChildScrollView(
              child: Column(
                children: [
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>BuilderPostItem(GraduationCubit.get(context).posts[index],context),
                    separatorBuilder: (context,index)=>SizedBox(
                      height: 5.h,
                    ),
                    itemCount: 10,
                  ),
                ],
              ),
            ),
            fallback: (context) => Center(child:  CircularProgressIndicator()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              navigateTo(context, NewPostScreen());
            },
            child: Icon(
                Icons.add
            ),
          ),
        );
      },

    );
  }

  Widget BuilderPostItem (PostModel model, context) =>  Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
        side: BorderSide(
            color: Colors.grey[500]!,
            width: 2.w
        ),
        borderRadius: BorderRadius.circular(
          20,
        )
    ),
    child: Padding(
      padding:  EdgeInsets.all(8.0.h),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.greenAccent,
                radius: 20,
                child: Image(
                  fit: BoxFit.cover,
                  image: model.image!.isEmpty||model.image!.isNotEmpty?AssetImage('assets/images/man.png'):AssetImage(
                      '${model.image}'
                  ),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  model.name==null?Text('name'):Text(
                    '${model.name}',
                  ),
                  model.dateTime==null?Text('12:00PM'):Text(
                      '${model.dateTime}'
                  ),
                ],
              ),
              Spacer(),
              TextButton(
                onPressed: (){},
                child: Text(
                    '+ Follow'
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${model.text}' ,style: TextStyle(
                fontSize: 16.sp
            ),
            ),
          ),
          myDivider(),
          Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Row(
                children:
                [
                  PostButton(icon: ImageIcon(AssetImage("assets/images/like.png"),size: 22.w,color: Colors.grey[600],), label: 'React', onTap: (){}),
                  PostButton(icon: ImageIcon(AssetImage("assets/images/comment.png"),size: 20.w,color: Colors.grey[600],), label: 'Comment', onTap: (){}),
                  PostButton(icon: ImageIcon(AssetImage("assets/images/repost.png"),size: 20.w,color: Colors.grey[600],), label: 'Repost', onTap: (){}),
                  PostButton(icon: ImageIcon(AssetImage("assets/images/send.png"),size: 20.w,color: Colors.grey[600],), label: 'Send', onTap: (){}),

                ],
              )
          ),
        ],
      ),
    ),
  );
}
class PostButton extends StatelessWidget {
  const PostButton({Key? key, required this.icon, required this.label, required this.onTap}) : super(key: key);
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
          child: Container(
            height: 25.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                icon,
                SizedBox(width: 4.0.w,),
                Text(label,style: TextStyle(fontSize: 12.sp),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

