import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/products/domain/models/product_model.dart';
import 'package:graduation/features/products/presentation/pages/products_page/products_cubit.dart';
import 'package:graduation/features/products/presentation/pages/products_page/products_state.dart';
import 'package:graduation/features/products/presentation/pages/products_page/widgets/product_item.dart';
import 'package:graduation/common/widgets/search_widget.dart';

class ProductsPage extends StatelessWidget {
  final String category;

  const ProductsPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(),
      child: ProductsPageBody(
        category: category,
      ),
    );
  }
}

class ProductsPageBody extends StatefulWidget {
  final String category;

  const ProductsPageBody({super.key, required this.category});

  @override
  State<ProductsPageBody> createState() => _ProductsPageBodyState();
}

class _ProductsPageBodyState extends State<ProductsPageBody> {
  @override
  void initState() {
    ProductsCubit.get(context).getProducts(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
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
                          Padding(
                            padding: EdgeInsets.only(top: 30.h),
                            child: Row(
                              children: [
                                Padding(
                                  padding:  EdgeInsets.only(left: 10.0.w),
                                  child: InkWell(
                                      onTap: () => Navigator.of(context).pop(),
                                      child: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.white,
                                      )),
                                ),
                                const Spacer(),
                                Text(
                                  widget.category,
                                  style:  TextStyle(
                                      color: Colors.white, fontSize: 20.sp),
                                ),
                                const Spacer(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          search_widget(),
                        ],
                      )
                    ],
                  ),
                  BlocBuilder<ProductsCubit, ProductsState>(
                      builder: (context, state) {
                    if (state.getProductState == RequestStatus.loading) {
                      return const Expanded(
                          child: Center(child: CircularProgressIndicator()));
                    } else if (state.getProductState == RequestStatus.success) {
                      return Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 5.0,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: state.products?.length ?? 0,
                          itemBuilder: (context, index) {
                            return ProductItem(
                              product: state.products?[index] ??
                                  ProductModel.initial(),
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  }),
                ],
              ),
            ),
          );
        });
  }
}
