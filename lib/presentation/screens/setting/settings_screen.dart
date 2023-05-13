import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding:  EdgeInsets.all(20.0.h),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Padding(
          padding:  EdgeInsets.only(top:12.0.h),
          child: Text('Settings',style: TextStyle(color: Colors.black,fontSize: 18.sp),),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(10.0.h),
        child: Column(
          children: [
            Row(
              children: [
                 CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 25.w,
                  child: Image(image: AssetImage('assets/images/user.png'))),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AhmedAyman',style: TextStyle(fontSize: 16.sp),),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text('Computer And Information',style: Theme.of(context).textTheme.bodySmall,)
                  ],
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                   color: Colors.grey[600],
                ))
                ],
            ),
            ListTile(
              leading: ImageIcon(AssetImage('')),
            )
          ],
        ),
      ),
    );
  }
}
