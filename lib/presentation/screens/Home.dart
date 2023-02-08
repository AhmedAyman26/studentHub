import 'package:flutter/material.dart';
import 'package:graduation/presentation/screens/chats/home_chat.dart';
import 'package:graduation/presentation/screens/posts/posts_screen.dart';
import 'package:graduation/presentation/screens/proucts/product_categories.dart';
import 'package:graduation/presentation/screens/services/services_Screen.dart';

import '../../shared/appBar_class.dart';

class tabs extends StatefulWidget {
  const tabs({Key? key}) : super(key: key);
  static const routeName = "3_tabs";
  @override
  State<tabs> createState() => _tabsState();
}

class _tabsState extends State<tabs> {
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            toolbarHeight: MediaQuery.of(context).size.height / 6,
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: ClipPath(
              clipper: CustomAppBarShape(),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Color.fromRGBO(70, 121, 112, 1.0),
                  ),
                  Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                        child: Row(
                          children: [
                            InkWell(
                              child: Container(
                                width: 25,
                                height: 25,
                                margin: EdgeInsets.all(1),
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
                                margin: EdgeInsets.all(1),
                                child: Image.asset(
                                  "assets/images/chat (2).png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        height: MediaQuery.of(context).size.height / 15,
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
                  ),
                ],
              ),
            ),
          ),
          body: TabBarView(
            children: tabsContent,
          )),
    );
  }
}
