import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/presentation/widgets/search_widget.dart';
import 'package:graduation/shared/widgets.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context,index)=>PostCard(),
              separatorBuilder: (context,index)=>SizedBox(
                height: 5.h,
              ),
              itemCount: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
            Icons.add
        ),
      ),
    );
  }

  Widget PostCard() {
    return Card(
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
                    image: AssetImage(
                        "assets/images/man.png"
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AhmedMohamed',
                    ),
                    Text(
                        '3:30 PM'
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
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, ...see more',style: TextStyle(
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

