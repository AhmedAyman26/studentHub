import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/product_model.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:graduation/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class GraduationCubit extends Cubit<GraduationStates> {
  GraduationCubit() : super(GraduationInitialState());
  static GraduationCubit get(context) => BlocProvider.of(context);

  List<DropdownMenuItem> items = [
    DropdownMenuItem(
      child: Text('Devices'),
      value: 'Devices',
    ),
    DropdownMenuItem(
      child: Text('Books'),
      value: 'Books',
    ),
    DropdownMenuItem(
      child: Text('Tools'),
      value: 'Tools',
    ),
    DropdownMenuItem(
      child: Text('Clothes'),
      value: 'Clothes',
    ),
  ];
  List<DropdownMenuItem> Universityitems = [
    DropdownMenuItem(
      child: Text('Zagaig University'),
      value: 'Zagaizg University',
    ),
    DropdownMenuItem(
      child: Text('Mansoura University'),
      value: 'Mansoura University',
    ),
  ];

  String? selectedItem;
  changeSelectedItem(value) {
    selectedItem = value;
    emit(ChangeSelectedItemState());
  }

  var imagePicker = ImagePicker();
  File? file;

  void showBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please Choose Image',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  var picked =
                      await ImagePicker().pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    file = File(picked.path);
                    var imageName = basename(picked.path);
                    // refSotrage =FirebaseStorage.instance.ref('images/$imageName');
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.photo_outlined,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'From Gallery',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  var picked =
                      await ImagePicker().pickImage(source: ImageSource.camera);
                  if (picked != null) {
                    file = File(picked.path);
                    var imageName = basename(picked.path);
                    // refSotrage =FirebaseStorage.instance.ref('images/$imageName');
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.camera_alt_outlined,
                        size: 30,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'From Camera',
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addProduct({
    required String id,
    required String name,
    required String category,
    required String image,
    required double price,
    required String description,
    required String studentId,
  }) {
    emit(AddProductLoadingState());
    ProductModel model=ProductModel(
        id: id,
        category: category,
        name: name,
        price: price,
        description: description,
        image: image,
        studentId: studentId,
    );
    FirebaseFirestore.instance.collection('products').add(
          model.toJson()).then((value)
    {
      emit(AddProductSuccessState());
    }
    ).catchError((error)
    {
      emit(AddProductErrorState());
    });

  }

//   ProductModel? model;
//   void addProduct({
//     required String category,
//     required String name,
//     required String price,
//     required String description,
// })
//   {
//     DioHelper.postData(
//         url: '/AddProduct/1', data:
//     {
//       'category':category,
//       'name':name,
//       'price':price,
//       'description':description
//     }).then((value)
//     {
//       print("+++++++++++=");
//       print(value.data is String);
//       // print("+++++++++++=");
//
//       model=ProductModel.fromJson(value.data);
//       print('============');
//       print(model!.status);
//       print('============');
//       emit(AddProductSuccessState());
//     });
//   }
//
//
//   void getProduct()
//   {
//     DioHelper.getData(url: '/AddProduct/1').then((value)
//     {
//       model=ProductModel.fromJson(value.data);
//       emit(GetProductSuccessState());
//     });
//
//   }

}
