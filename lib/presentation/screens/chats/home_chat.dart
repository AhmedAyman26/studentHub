import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:graduation/presentation/screens/chats/chat_screen.dart';
import 'package:graduation/presentation/widgets/search_widget.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/widgets.dart';

import '../../../shared/appBar_class.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GraduationCubit,GraduationStates>(
      listener: (context,state){},
      builder: (context,state)
      {
        return Scaffold(

          body: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 20.h),
                  child: Stack(
                    children:
                    [
                      Image(
                        image: AssetImage('assets/images/chatHeader.png'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(top: 20.h,left: 10.w ),
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: ()
                                    {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                    Icons.arrow_back_ios,
                                  size: 25.w,
                                  color: Colors.white,
                                )),
                                SizedBox(width: 5.w,),
                                Text('Chats',style: TextStyle(color: Colors.white,fontSize: 20.sp),),
                                Spacer(),
                                IconButton(
                                    onPressed: ()
                                    {
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
                          SizedBox(height: 40.h,),
                          search_widget(),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(right: 20.w,left: 20.w,bottom: 20.h),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context,index)=>buildChatItem(GraduationCubit.get(context).users[index],context),
                    separatorBuilder: (context,index)=>SizedBox(height: 15.h,),
                    itemCount: GraduationCubit.get(context).users.length,),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
Widget buildChatItem(UserData model,context)=> InkWell(
  onTap: ()
  {
    navigateTo(context, ChatScreen(
      user: model,
    ));
  },
  child: Row(
    children: [
       CircleAvatar(
        radius: 20.h,
        backgroundImage: NetworkImage(
            'https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=2048x2048&w=is&k=20&c=FLq43kh338qFN_JQSc262aRvFPBVlgDqhrG-sUtIIB8='
        ),
      ),
       SizedBox(
        width: 15.w,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              '${model.fullname}',
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
            // Row(
            //   children:const [
            //     Expanded(
            //       child: Text(
            //         'From Egypt ',
            //         maxLines: 1,
            //         overflow: TextOverflow.ellipsis,
            //       ),
            //     ),
            //     Padding(
            //       padding:  EdgeInsets.symmetric(
            //           horizontal: 10
            //       ),
            //     ),
            //     Text(
            //       '02:00 pm',
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    ],
  ),
);
