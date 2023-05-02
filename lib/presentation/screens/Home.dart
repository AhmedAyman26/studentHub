import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/presentation/screens/chats/home_chat.dart';
import 'package:graduation/presentation/screens/posts/posts_screen.dart';
import 'package:graduation/presentation/screens/proucts/product_categories.dart';
import 'package:graduation/presentation/screens/services/services_Screen.dart';

import '../widgets/search_widget.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);
  static const routeName = "3_tabs";
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Tab> tabs = [
    Tab(
      text: 'Post',
    ),
    Tab(
      text: 'Service',
    ),
    Tab(
      text: 'Product',
    ),
  ];
  List<Widget> tabsContent = [
    PostsScreen(),
    service_screen(),
    product_categories_screen(),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children:
                  [
                    Container(
                      width: double.infinity.w,
                      child: Image(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/path.png"),
                      ),
                    ),
                    Column(
                      children:
                      [
                        Row(
                          children:
                          [
                            InkWell(
                              child: Container(
                                width: 25.w,
                                height: 25.h,
                                margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/images/user (2).png",
                                ),
                              ),
                              onTap: (){},
                            ),
                            Spacer(),
                            InkWell(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatHomeScreen()));
                              },
                              child: Container(
                                width: 25.w,
                                height: 25.h,
                                margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/images/chat (2).png",
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(3.h),
                          height: MediaQuery.of(context).size.height / 25,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(103, 139, 133, 1.0),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TabBar(
                            isScrollable: true,
                            indicator: BoxDecoration(
                              color: Color.fromRGBO(70, 121, 112, 1.0),
                              borderRadius: BorderRadius.circular(15.0.w),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white,
                            tabs: tabs,
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        search_widget(),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: tabsContent,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}