 import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/presentation/screens/proucts/singleCategory_productsScreen.dart';
import 'package:graduation/shared/constants.dart';
class productCard_widget extends StatelessWidget {
  Color green=Color.fromRGBO(103, 139, 133, 1.0);
  Color darkGreen=Color.fromRGBO(70, 121, 112, 1.0);
  String image;
  final String name;
  productCard_widget(this.image,this.name);
  static const routeName="productCard_widget";

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ()
        {
          navigateTo(context, singleCategory_productsScreen(name.toString()));
        },
        child: Container(
          margin: EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height/6.5,
          child:  Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(
                color: green,
                width: 0.5,
              )
            ),
            shadowColor: Colors.grey,
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Image.asset(
                      '$image',
                      height: MediaQuery.of(context).size.height/6.5,
                      width: MediaQuery.of(context).size.width/2.3,
                      fit:BoxFit.fill

                  ),
                ),
                Container (alignment: Alignment.center,
                    width:MediaQuery.of(context).size.width/2.3 ,
                    child: Text("$name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:darkGreen),)),

              ],
            ),
          ),
        )
    );
  }
}
