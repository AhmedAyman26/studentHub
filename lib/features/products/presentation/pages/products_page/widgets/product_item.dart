import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:graduation/features/products/domain/models/product_model.dart';
import 'package:graduation/features/products/presentation/pages/products_page/widgets/product_details_page.dart';
import 'package:graduation/shared/constants.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:(){
        navigateTo(context,ProductDetailsPage(product));
      } ,
      child: Container(
        width: MediaQuery.of(context).size.width/2.2,
        height: MediaQuery.of(context).size.height/3.2,
        margin: const EdgeInsets.only(top: 4,left: 5,right: 5,bottom: 2),
        decoration:  BoxDecoration(
            color:  Colors.white,
            borderRadius:  BorderRadius.circular(10.0),

            boxShadow:const [BoxShadow(color:Colors.grey,
                offset: Offset(1,1),
                blurRadius: 7,
                spreadRadius: 1),
              BoxShadow(color:Colors.white)]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage("${product.studentImage}"),
                    backgroundColor: Colors.white,
                  ),
                ),
                FittedBox(child: Text("${product.studentName}",
                  style: const TextStyle(fontSize: 12),)),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.only(right: 5),
                  child: FavoriteButton(
                    isFavorite: false,
                    iconSize: 30,
                    valueChanged: (isFavorite) {
                      print('Is Favorite : $isFavorite');
                    },
                  ),
                ),
              ],
            ),

            SizedBox(
                width: MediaQuery.of(context).size.width/2.5,
                height: MediaQuery.of(context).size.height/10,
                child:Image(image:NetworkImage(product.image??''),)),
            FittedBox(fit: BoxFit.cover,
                child: Text("${product.name}",
                  style:const TextStyle(fontSize: 15,fontWeight: FontWeight.bold) ,)),
            const FittedBox(fit: BoxFit.cover,
                child: Text("Zagazig University",style:TextStyle(fontSize: 12,fontWeight: FontWeight.bold) ,)),
            SizedBox(
              height: MediaQuery.of(context).size.height/25,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(70, 121, 112, 1.0),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      padding: const EdgeInsets.all(8)
                  ),
                  onPressed: (){

                  },
                  child:SizedBox(
                    width: MediaQuery.of(context).size.width/3,
                    child: InkWell(
                      onTap: ()
                      {
                        // GraduationCubit.get(context).sendMessage(receiverId: state.getProductModel.products[index].firebase_id.toString(), dateTime: DateTime.now().toString(), text: 'Hello,i see you have ${state.getProductModel.products[index].productName} i need it..so can you help me?',image: state.getProductModel.products[index].productImage);
                      },
                      child: FittedBox(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add),
                            const Text("Request | ",style: TextStyle(),),
                            Text("${product.price} LE", style: const TextStyle(color: Colors.white70),),
                          ],
                        ),
                      ),
                    ),
                  )
              ),
            )


          ],
        ),
      ),
    );
  }
}
