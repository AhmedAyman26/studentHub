import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../../../shared/appBar_class.dart';

class productDetails_screen extends StatelessWidget {
  const productDetails_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
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
                     // alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: InkWell(
                                onTap: ()=> Navigator.of(context).pop(),
                                child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: Text("Details",style: TextStyle(color: Colors.white,fontSize: 20),),
                          ),
                          Spacer(),
                        ],
                      )

                  ),
                ),


              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FavoriteButton(
                    isFavorite: false,
                    iconSize: 40,
// iconDisabledColor: Colors.white,
                    valueChanged: (_isFavorite) {
                      print('Is Favorite : $_isFavorite');
                    },
                  ),
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height/4,
              width: double.infinity,
              child: Image.asset("assets/images/laptop-with-white-screen-isolated-white-wall.png",
              fit: BoxFit.cover,),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30,left: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(

                  children: [
                    Icon(Icons.location_on_outlined),
                    Text("Zagazig University",style: TextStyle(fontSize: 22),)
                  ],
                ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height/5,
                    child: Text('core i7-7200u ,\nRam 16 \nintel HD graphics 620 \n hard 1 Tera',
                      style:TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ) ,),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height*0.06,
                  ),

                ]
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height*0.07,
              width: MediaQuery.of(context).size.width*0.8,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary:Color.fromRGBO(70, 121, 112, 1.0),
                      elevation: 10, //elevation of button
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.all(8) //content padding inside button
                  ),
                  onPressed: (){
//code to execute when this button is pressed.
                  },
                  child:Container(
                    width: MediaQuery.of(context).size.width/2,
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
            ),
            

          ],
        ),
      ),
    );
  }
}
