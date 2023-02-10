import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/appBar_class.dart';
import '../../widgets/search_widget.dart';
import '../../widgets/singleCategoryCard_productWidget.dart';
class singleCategory_productsScreen extends StatelessWidget {
  List<String>image=["assets/images/laptop1.png",
  "assets/images/laptop3.png","assets/images/laptop4.png",
  "assets/images/laptop5.png","assets/images/laptop6.png"];
  String textP;
 singleCategory_productsScreen(this.textP);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/8,
                  child:ClipPath(
                    clipper: CustomAppBarShape(
                    ),
                    child: Stack(
                      alignment:Alignment.center ,
                      children: [
                        Container(
                          color:Color.fromRGBO(70, 121, 112, 1.0),
                          alignment: Alignment.center,
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 10,left:10,right:10),
                  child: Container(
                      color:Color.fromRGBO(70, 121, 112, 1.0),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                              onTap: ()=> Navigator.of(context).pop(),
                                child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                          ),
                          Spacer(),
                          Text("$textP",style: TextStyle(color: Colors.white,fontSize: 20),),
                          Spacer(),
                        ],
                      )

                  ),
                ),


              ],
            ),
            search_widget(),
           Expanded(
              child: ListView.builder(
                itemCount: image.length,
                itemBuilder: (context,index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      singleCategoryCard_productWidget(image[index]),
                      singleCategoryCard_productWidget(image[index]),
                    ],
                  );
                }

              ),
            ),

          ],
        ),
      ),
    );
  }
}
