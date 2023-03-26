import 'package:flutter/material.dart';
import 'package:graduation/presentation/screens/chats/home_chat.dart';
import 'package:graduation/presentation/screens/posts/posts_screen.dart';
import 'package:graduation/presentation/screens/proucts/product_categories.dart';
import 'package:graduation/presentation/screens/services/services_Screen.dart';

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
                    Image(
                      image: AssetImage("assets/images/path.png"),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                      [
                        Row(
                          children:
                          [
                            InkWell(
                              child: Container(
                                width: 25,
                                height: 25,
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
                                width: 25,
                                height: 25,
                                margin: EdgeInsets.all(10),
                                child: Image.asset(
                                  "assets/images/chat (2).png",
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height / 18,
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(103, 139, 133, 1.0),
                              borderRadius: BorderRadius.circular(20.0)),
                          child: TabBar(
                            isScrollable: true,
                            indicator: BoxDecoration(
                              color: Color.fromRGBO(70, 121, 112, 1.0),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.white,
                            tabs: tabs,
                          ),
                        ),
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
