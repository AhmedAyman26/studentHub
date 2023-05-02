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
    var scaffoldKey=GlobalKey<ScaffoldState>();
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
            child: Column(
              children: [
                Stack(
                  children:
                  [
                    Image(
                      fit: BoxFit.fitHeight,
                      image: AssetImage("assets/images/path.png"),
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
                              onTap: ()
                              {
                                scaffoldKey.currentState!.openDrawer();
                              },
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
          ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.h),
                    bottomLeft: Radius.circular(30.h),
                  ),
                  image: DecorationImage(fit: BoxFit.cover,
                    image: NetworkImage('https://static2.hdwallpapers.net/wallpapers/2019/02/24/1178/thumb_glass-building-in-toronto.jpg',),
                  )
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 10,
                  child: Icon(Icons.person),
                ),
                  accountName: Text('AhmedAyman',style: TextStyle(color: Colors.black),),
                  accountEmail: Text('ahmedzayan49@gmail.com'),

              ),
              ListTile(

                leading: ImageIcon(
                  AssetImage('assets/images/user.png'),color: Colors.black,),

                title: const Text('My Account'),

                onTap: () {
                },
              ),
              ListTile(
                leading: ImageIcon(AssetImage('assets/images/settings.png'),color: Colors.black,),
                title: const Text('Settings'),
                onTap: () {
                },
              ),
              ListTile(
                leading: ImageIcon(AssetImage('assets/images/product.png',),color: Colors.black,),
                title: const Text('My Products'),
                onTap: () {
                },
              ),
              ListTile(
                leading: ImageIcon(AssetImage('assets/images/service.png'),color: Colors.black,),
                title: const Text('My Services'),
                onTap: () {
                },
              ),
              ListTile(
                leading: ImageIcon(AssetImage('assets/images/favoits.png'),color: Colors.black,),
                title: const Text('Favourits'),
                onTap: () {
                },
              ),
            ],
          ),
        ),
         ),
    );
  }
}