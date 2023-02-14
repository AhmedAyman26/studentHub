import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/presentation/screens/proucts/add_product_screen.dart';
import 'package:graduation/shared/constants.dart';
import '../../widgets/productCard_widget.dart';
import '../../widgets/search_widget.dart';

class product_categories_screen extends StatelessWidget {
  static const routeName = "product_screen";
  Color green = Color.fromRGBO(103, 139, 133, 1.0);
  Color darkGreen = Color.fromRGBO(70, 121, 112, 1.0);
  List<String> name = [
    "Devices",
    "books",
    "IOT tools",
    "Engineering tools",
    "Chemical tools",
  ];
  List<String> image = [
    "assets/images/undraw_Devices_re_dxae.png",
    "assets/images/undraw_Bookshelves_re_lxoy.png",
    "assets/images/undraw_Circuit_board_re_1b79.png",
    "assets/images/undraw_QA_engineers_dg5p.png",
    "assets/images/undraw_Alien_science_re_0f8q.png",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          search_widget(),
          Expanded(
            child: ListView.builder(
              itemCount: name.length,
              itemBuilder: (context, index) {
                return productCard_widget(image[index], name[index]);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            navigateTo(context, AddProductScreen());
          }),
    );
  }
}
