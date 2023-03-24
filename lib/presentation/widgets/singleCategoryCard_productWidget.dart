import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/presentation/screens/proucts/productDetails_screen.dart';

import '../../shared/constants.dart';
import '../screens/proucts/add_product_screen.dart';
class singleCategoryCard_productWidget extends StatelessWidget {
   String image;
  singleCategoryCard_productWidget(this.image);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        navigateTo(context,productDetails_screen());
      },
      child: Container(
        width: MediaQuery.of(context).size.width/2.2,
        height: MediaQuery.of(context).size.height/3.2,
         margin: EdgeInsets.only(top: 5),
        decoration:  BoxDecoration(
            color:  Colors.white,
            borderRadius:  BorderRadius.circular(10.0),

            boxShadow:[BoxShadow(color:Colors.grey,
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
                    backgroundImage: AssetImage("assets/images/botswana (1).png"),
                    backgroundColor: Colors.white,
                  ),
                ),
                FittedBox(child: Text("Esraa Emad",style: TextStyle(fontSize: 12),)),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: FavoriteButton(
                    isFavorite: false,
                    iconSize: 30,
// iconDisabledColor: Colors.white,
                    valueChanged: (_isFavorite) {
                      print('Is Favorite : $_isFavorite');
                    },
                  ),
                ),

              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width/2.5,
              height: MediaQuery.of(context).size.height/12,
              child:ClipRRect(
                borderRadius: BorderRadius.only(topLeft:Radius.circular(15),
                    topRight: Radius.circular(15)),
                child: Image(
                  image: AssetImage("$image"),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
              ),),
            FittedBox(fit: BoxFit.cover,
                child: Text("DEll inspiron 10th i7 16G",style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold) ,)),
            FittedBox(fit: BoxFit.cover,
                child: Text("Zagazig University",style:TextStyle(fontSize: 12,fontWeight: FontWeight.bold) ,)),
            Container(
              height: MediaQuery.of(context).size.height/25,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:Color.fromRGBO(70, 121, 112, 1.0),
                      elevation: 3, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)
                      ),
                      padding: EdgeInsets.all(8) //content padding inside button
                  ),
                  onPressed: (){

                  },
                  child:Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: FittedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          Text("Request | ",style: TextStyle(),),
                          Text("15000 LE", style: TextStyle(color: Colors.white70),),
                        ],
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
