import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/app_injector.dart';
import 'package:graduation/features/products/domain/models/inputs/add_product_input.dart';
import 'package:graduation/features/products/presentation/pages/add_product_page/add_product_cubit.dart';
import 'package:graduation/features/products/presentation/pages/add_product_page/add_product_state.dart';
import 'package:graduation/shared/cubits/user_cubit/user_cubit.dart';
import 'package:graduation/shared/cubits/user_cubit/user_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation/shared/styles/colors.dart';
import 'package:graduation/shared/utils.dart';
import 'package:graduation/shared/widgets.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductCubit(injector()),
      child: const AddProductPageBody(),
    );
  }
}

class AddProductPageBody extends StatefulWidget {
  const AddProductPageBody({super.key});

  @override
  State<AddProductPageBody> createState() => _AddProductPageBodyState();
}

class _AddProductPageBodyState extends State<AddProductPageBody> {
  TextEditingController productNameController = TextEditingController();

  TextEditingController productPriceController = TextEditingController();

  TextEditingController productDescriptionController = TextEditingController();

  String? productImageLink;

  int? categoryId;

  String? selectedCategory;

  List<String> categories = [
    'Devices',
    'Books',
    'Electronic tools',
    'Engineering tools',
    'Medical tools',
    'Chemical tools',
    'Others'
  ];

  @override
  void dispose() {
    productNameController.dispose();
    productDescriptionController.dispose();
    productPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddProductCubit, AddProductState>(
      listener: (context, state) {
        if (state.addProductState == RequestStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.message),
            backgroundColor: AppColors.appGreen,
          ));
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            titleSpacing: 1,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                icon: const Icon(color: Colors.black, Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context)!.add_product,
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              BlocBuilder<UserCubit, UserState>(
                builder: (context, userState) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async {
                        AddProductCubit.get(context).addProduct(AddProductInput(
                            productName: productNameController.text,
                            productImage: productImageLink,
                            productDescription:
                                productDescriptionController.text,
                            categoryId: categoryId.toString(),
                            price: productPriceController.text,
                            studentId: userState.userData?.studentId ?? ''));
                      },
                      child: Text(AppLocalizations.of(context)!.add_product),
                    ),
                  );
                },
              ),
            ],
          ),
          body: BlocBuilder<UserCubit, UserState>(
            builder: (context, userState) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(userState.userData?.image ?? ''),
                            radius: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(userState.userData?.fullName ?? ''),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      InkWell(
                        onTap: () {
                          showSelectImageBottomSheet(context, (image) async {
                            await FirebaseStorage.instance
                                .ref()
                                .child(
                                    'products/${Uri.file(image.path).pathSegments.last}')
                                .putFile(image)
                                .then((value) {
                              value.ref.getDownloadURL().then((value) {
                                productImageLink = value;
                              });
                            });
                            Navigator.of(context).pop();
                          });
                        },
                        child: Icon(
                          Icons.add_a_photo_outlined,
                          size: 100,
                          color: Colors.grey[600],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: DropdownButton(
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: categories
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          hint: Text(
                              AppLocalizations.of(context)!.select_category),
                          onChanged: (val) {
                            selectedCategory = val;
                            categoryId = categories.indexOf(val ?? '') + 1;
                            setState(() {});
                            // GraduationCubit.get(context).changeSelectedItem(val);
                          },
                          isExpanded: true,
                          value: selectedCategory,
                        ),
                      ),
                      TextFormField(
                          controller: productNameController,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.product_name,
                          )),
                      TextFormField(
                          controller: productPriceController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.price,
                          )),
                      TextField(
                        controller: productDescriptionController,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.description),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
