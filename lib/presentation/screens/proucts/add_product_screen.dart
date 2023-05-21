import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatelessWidget {
  var productNameController = TextEditingController();
  var productPriceController = TextEditingController();
  var productDescriptionController = TextEditingController();

  AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    String selectedUniversity = 'Zagazig';

    return BlocConsumer<GraduationCubit, GraduationStates>(
      listener: (context, state) {
        if(state is AddProductSuccessState){
          if(state.addProductModel.success==true) {
            Navigator.of(context).pop();
          }
        }
        else{print("-------------------------");}
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
                    icon: Icon(color: Colors.black, Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                backgroundColor: Colors.white,
                title: Text(
                  style: TextStyle(color: Colors.black),
                  'Add Product',
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      onPressed: () async{
                        if(state is AddProductLoadingState){
                           Center(child: CircularProgressIndicator());
                         }else //if(state is AddProductSuccessState)
                           {

                        print(GraduationCubit.get(context).imageToAPI.toString());

                        print(GraduationCubit.get(context).selectedItem.toString());
                        print('++++++++++++++');
                          GraduationCubit.get(context).addProduct(

                              product_name: productNameController.text,
                              product_image:'${GraduationCubit.get(context).imageToAPI}',
                              category_id: GraduationCubit.get(context).selectedItem.toString(),
                              price:productPriceController.text,
                              product_desc: productDescriptionController.text,
                              student_id: "142");

                          }
                        },
                      // },
                      child: Text('Post'),
                    ),
                  ),
                ],
                // leading: Icon(
                //     Icons.arrow_back_ios,
                // ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.greenAccent,
                            radius: 20,
                            child: Image(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/man.png"),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            children: [
                              Text(
                                '${FirebaseAuth.instance.currentUser?.displayName??'default'}',
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          GraduationCubit.get(context).showProductBottomSheet(context);
                        },
                        child: Container(
                          child:/*GraduationCubit.get(context).imagePicker==null?
                        Icon(Icons.add_task,
                          size: 100,
                          color: Colors.grey[600],):*/
                          Icon(
                            Icons.add_a_photo_outlined,
                            size: 100,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10),
                        child: DropdownButton(
                          icon: Icon(Icons.keyboard_arrow_down_rounded),
                          items: GraduationCubit.get(context).items,
                          hint: Text('Select Category'),
                          onChanged: (val) {
                            GraduationCubit.get(context).changeSelectedItem(val);
                          },
                          isExpanded: true,
                          value: GraduationCubit.get(context).selectedItem,
                        ),
                      ),
                      TextFormField(
                          controller: productNameController,
                          decoration: InputDecoration(
                            labelText: 'Product Name',
                          )),
                      TextFormField(
                          controller: productPriceController,
                          decoration: InputDecoration(
                            labelText: 'Price (Optional)',
                          )),
                      TextField(
                        controller: productDescriptionController,
                        maxLines: 4,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                    ],
                  ),
                ),
              ),
            );
      },
    );
  }
}
