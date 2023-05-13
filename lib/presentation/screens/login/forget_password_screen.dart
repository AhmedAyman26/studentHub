import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/shared/styles/colors.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Stack(children: [
                Container(
                  width: double.infinity,
                  child: Image(
                    image: AssetImage('assets/images/forgetpassword.png'),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20.0.h),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 30.h,
                      )),
                )
              ]),
            ),
            Padding(
              padding:  EdgeInsets.all(30.0.h),
              child: Text('Enter Your Email',style: TextStyle(
                fontSize: 25.sp,
                fontWeight: FontWeight.w400,
                color: kPrimaryColor
              ),),
            ),
            Padding(
              padding:  EdgeInsets.all(20.0.w),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        width: 3, color: Colors.black12),
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),

                ),

              ),
            ),
            Center(
              child: Container(
                width: 200.w,
                height: 40.h,
                child: MaterialButton(
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  onPressed: ()
                  {
                  },
                  child: Text("Recover Password",
                    style:TextStyle(color: Colors.white,fontSize: 21),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
