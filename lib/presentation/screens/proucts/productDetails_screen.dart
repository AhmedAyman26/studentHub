import 'dart:convert';
import 'dart:typed_data';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../logic/cubit/cubit.dart';
import '../../../logic/cubit/states.dart';
import '../../../shared/appBar_class.dart';

class productDetails_screen extends StatefulWidget {
  //productDetails_screen(int index, String s);

  final String name;
  final int Index;
  productDetails_screen(this.Index,this.name);

  @override
  State<productDetails_screen> createState() => _productDetails_screenState();
}

class _productDetails_screenState extends State<productDetails_screen> {
  //const productDetails_screen({Key? key}) : super(key: key);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GraduationCubit.get(context).getProduct(category:"${widget.name}");
  }
  Widget image(String thumbnail) {
    if (thumbnail.length % 4 > 0) {
      thumbnail += '=' * (4 - thumbnail .length % 4); // as suggested by Albert221
    }
    final _byteImage = Base64Decoder().convert(thumbnail);
    Widget image = Image.memory(_byteImage,
      fit: BoxFit.fill,
      width: double.infinity,
      height: double.infinity,);
    return image;
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GraduationCubit,GraduationStates >(
        listener: (context, state) {},
    builder: (context, state) {
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
            BlocBuilder<GraduationCubit,GraduationStates>(
            builder: (context, state){
              if (state is GetProductLoadingState)
            {
              return Expanded(child: Center(child: CircularProgressIndicator()));
            }else if(state is GetProductSuccessState){
             return Column(
              children: [
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
                  padding:EdgeInsets.only(left:20,right: 20),
                  height: MediaQuery.of(context).size.height/4,
                  width: double.infinity,
                  child: image(state.getProductModel.products[widget.Index].productImage.toString()),
                  /*Image.asset("assets/images/laptop-with-white-screen-isolated-white-wall.png",
                    fit: BoxFit.cover,),*/
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30,left: 20,right:16),
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
                          padding: EdgeInsets.only(top:2),
                          alignment: Alignment.centerLeft,
                          height: MediaQuery.of(context).size.height/4,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                /* Row(children: [
                            Text("Name:",style: TextStyle(color: Colors.black,fontSize: 20),)
                          ],),*/
                                Text("${state.getProductModel.products[widget.Index].productDesc}",
                                  style:TextStyle(
                                    color: Colors.grey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ) ,),
                              ],
                            ),
                          ),
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
                        // print(widget.Index);
                        // print(widget.catigory);
                      },
                      child:Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: FittedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add),
                              Text("Request | ",style: TextStyle(),),
                              Text("${state.getProductModel.products[widget.Index].price} LE", style: TextStyle(color: Colors.white70),),
                            ],
                          ),
                        ),
                      )
                  ),
                ),
              ],
            );

              } else{
                return SizedBox();
              }
    }

            )

          ],
        ),
      ),
    );}
    );
  }
}
