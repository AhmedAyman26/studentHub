import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/presentation/screens/proucts/add_product_screen.dart';
import 'package:graduation/shared/constants.dart';
import '../../widgets/productCard_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class product_categories_screen extends StatelessWidget {
  Color green = Color.fromRGBO(103, 139, 133, 1.0);
  Color darkGreen = Color.fromRGBO(70, 121, 112, 1.0);


 final List<String> image = [
    "assets/images/undraw_Devices_re_dxae.png",
    "assets/images/undraw_Bookshelves_re_lxoy.png",
    "assets/images/undraw_Circuit_board_re_1b79.png",
    "assets/images/undraw_QA_engineers_dg5p.png",
    "assets/images/undraw_Alien_science_re_0f8q.png",
    "assets/images/undraw_Alien_science_re_0f8q.png",
    "assets/images/undraw_Alien_science_re_0f8q.png",
  ];
  @override
  Widget build(BuildContext context) {
    final List<String> name = [
      AppLocalizations.of(context)!.devices,
    AppLocalizations.of(context)!.book,
    AppLocalizations.of(context)!.electronic_tool,
    AppLocalizations.of(context)!.engineering_tools,
    AppLocalizations.of(context)!.medical_tools,
    AppLocalizations.of(context)!.chemical_tools,
    AppLocalizations.of(context)!.others
    ];
    final List<String> name2 = [
      "Devices",
      "Books",
      "Electronic tools",
      "Engineering tools",
      "Medical tools",
      "Chemical tools",
      "others"
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: name.length,
              itemBuilder: (context, index) {
                return ProductCardWidget(image[index].toString(), name[index].toString(),name2[index].toString());
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
