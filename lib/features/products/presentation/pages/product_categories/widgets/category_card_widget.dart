import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/constants.dart';
import 'package:graduation/common/styles/colors.dart';
import 'package:graduation/features/products/presentation/pages/products_page/products_page.dart';


class CategoryCardWidget extends StatelessWidget {
  final String categoryImage;
  final String categoryName;

  const CategoryCardWidget(
      {super.key, required this.categoryImage, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          navigateTo(context, ProductsPage(category: categoryName));
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height / 6.5,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: AppColors.appGreen,
                  width: 0.5,
                )),
            shadowColor: Colors.grey,
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Image.asset(categoryImage,
                      height: MediaQuery.of(context).size.height / 6.5,
                      width: MediaQuery.of(context).size.width / 2.3,
                      fit: BoxFit.fill),
                ),
                SizedBox(
                    width: MediaQuery.of(context).size.width / 2.3,
                    child: Text(
                      categoryName,
                      style:  TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.appDarkGreen),
                    )),
              ],
            ),
          ),
        ));
  }
}
