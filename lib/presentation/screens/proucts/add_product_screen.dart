import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/logic/cubit/states.dart';

class AddProductScreen extends StatelessWidget {

  var productNameController=TextEditingController();
  var productPriceController=TextEditingController();
  var productDescriptionController=TextEditingController();

  AddProductScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GraduationCubit, GraduationStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Add Product',
            ),
            // leading: Icon(
            //     Icons.arrow_back_ios,
            // ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children:
                [
                  InkWell(
                    onTap: ()
                    {
                      GraduationCubit.get(context).showBottomSheet(context);
                    },
                    child: Container(
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        size: 100,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: 10
                    ),
                    child: DropdownButton(
                      icon: Icon(
                          Icons.keyboard_arrow_down_rounded
                      ),
                      items: GraduationCubit.get(context).items,
                      hint: Text('Select Category'),
                      onChanged: (val)
                      {
                        GraduationCubit.get(context).changeSelectedItem(val);
                      },
                      isExpanded: true,
                      value: GraduationCubit.get(context).selectedItem,
                    ),
                  ),
                  TextFormField(
                    controller:productNameController,
                      decoration: InputDecoration(
                        labelText: 'Product Name',
                      )
                  ),
                  TextFormField(
                    controller:productPriceController,
                      decoration: InputDecoration(
                        labelText: 'Price (Optional)',
                      )
                  ),
                  TextField(
                    controller: productDescriptionController,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      labelText: 'Description'
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: ()
                          {
                            GraduationCubit.get(context).addProduct(
                              category: GraduationCubit.get(context).selectedItem!,
                              name: productNameController.text,
                              price: productPriceController.text,
                              description: productDescriptionController.text,
                            );
                          },
                          child:Text(
                          'Add Product'
                        ),
                        ),
                      ),
                    ],
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
