import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/cubits/user_cubit/user_cubit.dart';
import 'package:graduation/features/chats/data/models/api_message_model.dart';
import 'package:graduation/features/products/domain/models/product_model.dart';
import 'package:graduation/features/products/presentation/pages/products_page/products_cubit.dart';

class ProductDetailsPage extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsPage(this.product, {super.key});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
                            padding: EdgeInsets.only(left: 10.0.w),
                            child: InkWell(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                )),
                          ),
                          const Spacer(),
                          Text(
                            widget.product.name ?? '',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.sp),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: FavoriteButton(
                        isFavorite: false,
                        iconSize: 40,
                        valueChanged: (isFavorite) {},
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  height: MediaQuery.of(context).size.height / 4,
                  width: double.infinity,
                  child: Image(image: NetworkImage(widget.product.image ?? '')),
                  /*Image.asset("assets/images/laptop-with-white-screen-isolated-white-wall.png",
                    fit: BoxFit.cover,),*/
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 16),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.location_on_outlined),
                            Text(
                              "Zagazig University",
                              style: TextStyle(fontSize: 22),
                            )
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 2),
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height / 4,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  "${widget.product.description}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06,
                        ),
                      ]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(70, 121, 112, 1.0),
                          elevation: 10, //elevation of button
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8)),
                      onPressed: () {
                        ProductsCubit.get(context)
                            .requestProduct(ApiMessageModel(
                          receiverId: widget.product.firebaseId,
                          image: widget.product.image,
                          senderId:
                              UserCubit.get(context).state.userData?.firebaseId,
                          dateTime: DateTime.now().toString(),
                          text:
                              'Hello,i see you have ${widget.product.name} i need it..so can you help me?',
                        ));
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.add),
                              const Text(
                                "Request | ",
                                style: TextStyle(),
                              ),
                              Text(
                                "${widget.product.price} LE",
                                style: const TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
