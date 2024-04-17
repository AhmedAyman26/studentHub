import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/common/utils/constants/app_constants.dart';
import 'package:graduation/common/utils/constants/image_paths.dart';
import 'package:graduation/features/products/presentation/pages/add_product_page/add_product_page.dart';
import 'widgets/category_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductCategoriesPage extends StatefulWidget {


  const ProductCategoriesPage({super.key});

  @override
  State<ProductCategoriesPage> createState() => _ProductCategoriesPageState();
}

class _ProductCategoriesPageState extends State<ProductCategoriesPage> {
 final List<String> images = [
   ImagesPaths.devices,
   ImagesPaths.books,
   ImagesPaths.electronicTools,
   ImagesPaths.engineering,
   ImagesPaths.chemistry,
   ImagesPaths.chemistry,
   ImagesPaths.sharing,
  ];

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
