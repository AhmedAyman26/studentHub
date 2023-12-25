import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/common/constants.dart';
import 'package:graduation/features/products/presentation/pages/add_product_page/add_product_screen.dart';
import 'widgets/category_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCategoriesPage extends StatelessWidget {

 final List<String> images = [
    "assets/images/undraw_Devices_re_dxae.png",
    "assets/images/undraw_Bookshelves_re_lxoy.png",
    "assets/images/undraw_Circuit_board_re_1b79.png",
    "assets/images/undraw_QA_engineers_dg5p.png",
    "assets/images/undraw_Alien_science_re_0f8q.png",
    "assets/images/undraw_Alien_science_re_0f8q.png",
    "assets/images/undraw_Alien_science_re_0f8q.png",
  ];

  ProductCategoriesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final List<String> names = [
      AppLocalizations.of(context)!.devices,
    AppLocalizations.of(context)!.book,
    AppLocalizations.of(context)!.electronic_tool,
    AppLocalizations.of(context)!.engineering_tools,
    AppLocalizations.of(context)!.medical_tools,
    AppLocalizations.of(context)!.chemical_tools,
    AppLocalizations.of(context)!.others
    ];


    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return CategoryCardWidget(categoryImage: images[index].toString(),categoryName: names[index].toString());
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn',
          child: const Icon(Icons.add),
          onPressed: () {
            navigateTo(context, const AddProductPage());
          }),
    );
  }
}
