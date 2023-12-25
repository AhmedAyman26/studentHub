import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/styles/colors.dart';
import 'package:graduation/common/widgets/search_widget.dart';

class ServicesPage extends StatelessWidget {
  final String serviceType;
  const ServicesPage({Key? key, required this.serviceType}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                const Image(
                  image: AssetImage('assets/images/chatHeader.png'),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 20.h, left: 10.w),
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 25.w,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            serviceType,
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    search_widget(),
                  ],
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.all(MediaQuery.of(context).size.width/500),
                  height: MediaQuery.of(context).size.height / 6.5,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: AppColors.appGreen,
                          width: 1.w,
                        )),
                    shadowColor: Colors.grey,
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Image(
                          image: AssetImage(
                            'assets/images/servicePDF.png',
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/100,
                        ),
                        Expanded(
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Padding(
                               padding:  EdgeInsets.only(right: MediaQuery.of(context).size.width/50,top: MediaQuery.of(context).size.height/404),
                               child: Row(
                                 children: [
                                   Text('Ahmed Ayman',style: TextStyle(fontSize: 18.sp),),
                                   const Spacer(),
                                   InkWell(
                                     onTap: (){},
                                     child: const Icon(Icons.file_download_outlined),
                                   ),
                                   InkWell(
                                     onTap: (){},
                                     child: const Icon(Icons.more_vert_outlined),
                                   ),
                                 ],
                               ),
                             ),
                             SizedBox(
                               height: MediaQuery.of(context).size.height/100,
                             ),
                             Text("This book is often said to be the bible for Algorithms.\n The book has a lot of famous algorithms ranging \n from a variety of topics like Dynamic Programming,\n Greedy methods, various advanced ",style: TextStyle(fontSize: 10.sp),maxLines: 4,overflow: TextOverflow.ellipsis,),
                           ],
                         ),
                       ),
                      ],
                    ),
                  ),
                ),
                itemCount: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
