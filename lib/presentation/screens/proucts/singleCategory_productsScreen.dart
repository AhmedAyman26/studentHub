import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:graduation/presentation/screens/chats/chat_screen.dart';
import 'package:graduation/presentation/screens/chats/home_chat.dart';
import 'package:graduation/presentation/screens/proucts/productDetails_screen.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import '../../../logic/cubit/cubit.dart';
import '../../../shared/appBar_class.dart';
import '../../../shared/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SingleCategoryProductPage extends StatefulWidget {
  final String name;
  final String name2;
  const SingleCategoryProductPage(this.name,this.name2, {super.key});

  @override
  State<SingleCategoryProductPage> createState() => _SingleCategoryProductPageState();
}

class _SingleCategoryProductPageState extends State<SingleCategoryProductPage> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    GraduationCubit.get(context).getProduct(category:widget.name2);
  }
late List<dynamic> allProducts;
late List<dynamic> searchedForProduct;
Color green=Color.fromRGBO(103, 139, 133, 1.0);
var _searchController = TextEditingController();

// Widget image(String thumbnail) {
//     if (thumbnail.length % 4 > 0) {
//       thumbnail += '=' * (4 - thumbnail .length % 4); // as suggested by Albert221
//   }
//   final _byteImage = Base64Decoder().convert(thumbnail);
//   Widget image = Image.memory(_byteImage,
//     fit: BoxFit.fill,
//     width: double.infinity,
//     height: double.infinity,);
//   return image;
// }
  @override
  Widget build(BuildContext context) {
   return BlocConsumer<GraduationCubit,GraduationStates >(
        listener: (context, state) {},
    builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(
        child: Column(
          children: [
            ///abbBar
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
                          Text("${widget.name}",style: TextStyle(color: Colors.white,fontSize: 20),),
                          Spacer(),
                        ],
                      )

                  ),
                ),


              ],
            ),
            ///search/////////////
                BlocBuilder<GraduationCubit,GraduationStates>(
                 builder: (context, state) {
                  if(state is GetProductSuccessState) {
                    return Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width / 1.4,
                      margin: EdgeInsets.only(bottom: 5),
                      height: 35,
                      child: TextField(
                        controller: _searchController,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15
                        ),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(
                                20.0, 15.0, 20.0, 15.0),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(50),),
                              borderSide: BorderSide(
                                color: green,
                                width: 1.0,),),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: green,
                                width: 2.0,
                              ),
                            ),
                            fillColor: Colors.transparent,
                            prefixIcon: Icon(
                              Icons.search, size: 25, color: Colors.grey,),
                            hintText: AppLocalizations.of(context)!.search,
                            hintStyle: TextStyle(
                              color: Colors.grey, fontSize: 15,)
                        ),
                        onChanged: (searchedProduct) {
                          addSearchedForItemsToSearchedList(searchedProduct){
                            for(int i=0;i>=state.getProductModel.products.length;i++){
                             var productIndex=state.getProductModel.products[i];
                            searchedForProduct=allProducts.where((product) =>state.getProductModel.products[i].productName.toLowerCase().startsWith(searchedProduct) ).toList();
                            print(searchedProduct);}
                          };
                        },
                        /*onChanged: (searchedProduct) {
                          setState(() {
                            searchedForProduct = allProducts
                                .where((product) =>
                                state.getProductModel.products[product].productName.toLowerCase().startsWith(searchedProduct))
                                .toList();
                          });
                        },
                        */
                      ),
                    );
                  }
                  else{
                    return SizedBox();
                  }
    }),
            BlocBuilder<GraduationCubit,GraduationStates>(
            builder: (context, state) {
              if (state is GetProductLoadingState){
                return Expanded(child: Center(child: CircularProgressIndicator()));
              }else if(state is GetProductSuccessState){
                 allProducts =state.getProductModel.products;
              return Expanded(
              child:GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5.0,
                  //crossAxisSpacing: 10.0,
                  childAspectRatio: 0.75,
                ),
                itemCount: state.getProductModel.products.length,
                itemBuilder: (context, index) {
                //  var _decodedImage = base64Decode(state.getProductModel.products[index].image);
                  return InkWell(
                    onTap:(){
                      //int indexp=index;
                      navigateTo(context,ProductDetailsPage(index,"${widget.name}"));
                    } ,
                    child: Container(
                      width: MediaQuery.of(context).size.width/2.2,
                      height: MediaQuery.of(context).size.height/3.2,
                      margin: EdgeInsets.only(top: 4,left: 5,right: 5,bottom: 2),
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
                                  backgroundImage: NetworkImage("${state.getProductModel.products[index].image}"),
                                  backgroundColor: Colors.white,
                                ),
                              ),
                              FittedBox(child: Text("${state.getProductModel.products[index].fullname}",
                                style: TextStyle(fontSize: 12),)),
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
                            height: MediaQuery.of(context).size.height/10,
                            child:Image(image:NetworkImage(state.getProductModel.products[index].productImage.toString()),)),
                          FittedBox(fit: BoxFit.cover,
                              child: Text("${state.getProductModel.products[index].productName}",
                                style:TextStyle(fontSize: 15,fontWeight: FontWeight.bold) ,)),
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
                                  child: InkWell(
                                    onTap: ()
                                    {
                                      GraduationCubit.get(context).sendMessage(receiverId: state.getProductModel.products[index].firebase_id.toString(), dateTime: DateTime.now().toString(), text: 'Hello,i see you have ${state.getProductModel.products[index].productName} i need it..so can you help me?',image: state.getProductModel.products[index].productImage);
                                    },
                                    child: FittedBox(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add),
                                          Text("Request | ",style: TextStyle(),),
                                          Text("${state.getProductModel.products[index].price} LE", style: TextStyle(color: Colors.white70),),
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
                },
              )
                /* ListView.builder(
                itemCount: state.getProductModel.products.length,
                itemBuilder: (context,index){
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      singleCategoryCard_productWidget(image[index]),
                      singleCategoryCard_productWidget(image[index]),
                    ],
                  );
                }

              ),*/
            );}
              else{
                return SizedBox();
              }
            }
            ),
          ],
        ),
      ),
    );
    }
    );
  }
}

