import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/features/chats/presentation/pages/users_page/home_chat.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_screen.dart';
import 'package:graduation/features/products/presentation/pages/product_categories/product_categories_page.dart';
import 'package:graduation/features/services/presentation/pages/subjects_page/subjects_page.dart';
import 'package:graduation/features/setting/presentation/settings_screen.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/cubits/user_cubit/user_cubit.dart';
import '../widgets/search_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  static const routeName = "3_tabs";

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Tab> tabs = [
      Tab(
        text: AppLocalizations.of(context)!.posts,
      ),
      Tab(
        text: AppLocalizations.of(context)!.services,
      ),
      Tab(
        text: AppLocalizations.of(context)!.products,
      ),
    ];
    List<Widget> tabsContent = [
      const PostPage(),
      SubjectsPage(),
      ProductCategoriesPage(),
    ];
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        key: scaffoldKey,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Image(
                      width: double.infinity,
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/chatHeader.png"),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            child: Container(
                              width: 25.w,
                              height: 25.h,
                              margin: const EdgeInsets.all(10),
                              child: Image.asset(
                                "assets/images/user (2).png",
                              ),
                            ),
                            onTap: () {
                              scaffoldKey.currentState!.openDrawer();
                            },
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              // GraduationCubit.get(context).getUsers();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ChatHomePage()));
                            },
                            child: Container(
                              width: 25.w,
                              height: 25.h,
                              margin: const EdgeInsets.all(10),
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
                            color: const Color.fromRGBO(103, 139, 133, 1.0),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: TabBar(
                          isScrollable: true,
                          indicator: BoxDecoration(
                            color: const Color.fromRGBO(70, 121, 112, 1.0),
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
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        'https://static2.hdwallpapers.net/wallpapers/2019/02/24/1178/thumb_glass-building-in-toronto.jpg',
                      ),
                    )),
                currentAccountPicture:  CircleAvatar(
                  radius: 10,
                  backgroundImage: NetworkImage(  UserCubit.get(context).state.userData?.image??''),
                ),
                accountName: Text(
                    UserCubit.get(context).state.userData?.fullName??''),
                // '${GraduationCubit.get(context).user?.fullname??'ahmed'}',style: TextStyle(color: Colors.black),),
                accountEmail: Text(  UserCubit.get(context).state.userData?.email??''),
              ),
              ListTile(
                leading: const ImageIcon(
                  AssetImage('assets/images/user.png'),
                  color: Colors.black,
                ),
                title: Text(AppLocalizations.of(context)!.my_account),
                onTap: () {},
              ),
              ListTile(
                leading: const ImageIcon(
                  AssetImage('assets/images/settings.png'),
                  color: Colors.black,
                ),
                title: Text(AppLocalizations.of(context)!.settings),
                onTap: () {
                  navigateTo(context, const SettingsScreen());
                },
              ),
              ListTile(
                leading: const ImageIcon(
                  AssetImage(
                    'assets/images/product.png',
                  ),
                  color: Colors.black,
                ),
                title: Text(AppLocalizations.of(context)!.my_products),
                onTap: () {},
              ),
              ListTile(
                leading: const ImageIcon(
                  AssetImage('assets/images/service.png'),
                  color: Colors.black,
                ),
                title: Text(AppLocalizations.of(context)!.my_services),
                onTap: () {},
              ),
              ListTile(
                leading: const ImageIcon(
                  AssetImage('assets/images/favoits.png'),
                  color: Colors.black,
                ),
                title: Text(AppLocalizations.of(context)!.favourits),
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
