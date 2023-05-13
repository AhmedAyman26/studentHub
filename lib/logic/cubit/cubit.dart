import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/addProduct_model.dart';
import 'package:graduation/data/models/getProduct_model.dart';
import 'package:graduation/data/models/message_model.dart';
import 'package:graduation/data/models/product_model.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:graduation/logic/register_cubit/cubit.dart';
import 'package:graduation/shared/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class GraduationCubit extends Cubit<GraduationStates> {
  GraduationCubit() : super(GraduationInitialState());
  static GraduationCubit get(context) => BlocProvider.of(context);

  UserData? user;

  void getUserData() async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      print("++++++++++++++");
      print(value.id);
      print(value.data());
      print("++++++++++");
      user = UserData.fromJson(value.data()!);
      print(user!.uId);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }
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
  String ?imageToAPI;
  Future showBottomSheet(context) async{

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
                    //ConvertImage(picked as XFile);
                    imageToAPI =await ConvertImage(file!);
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
                    //ConvertImage(picked as XFile);
                    // refSotrage =FirebaseStorage.instance.ref('images/$imageName');
                    imageToAPI =await convertImageToBase64(file!);
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
  Future ConvertImage(File picked)async{
    Uint8List imageBytes=await picked.readAsBytes();
    String base64string=
    base64.encode(imageBytes);
    //print(".............................................");
    return base64string;
  }
  ////////////////////////////////
  Future<String?> imageToBase64(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return null;

    final bytes = await pickedFile.readAsBytes();
    final base64 = base64Encode(bytes);
    return base64;
  }
////////////////////////////////
  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

////////////////////////////////
  AddProductModel?addProductModel;
  void addProduct({
    required String product_name,
    required String category_id,
    required String product_image,
    required String price,
    required String product_desc,
    required String student_id,
  }){
    emit(AddProductLoadingState());
    DioHelper.postData(url: 'product.php',
        data:{
          'student_id': "241",
          'product_name':product_name,
          'product_image':product_image,
          'product_desc':product_desc,
          'category_id':category_id,
          //category_id,
          //GraduationCubit().changeSelectedItem(value).toString(),
          'price':price


        }).then((value)
    {
      print(value.data);
      Map<String,dynamic>JsonData=json.decode(value.data);
      addProductModel=AddProductModel.fromJson(JsonData);
      emit(AddProductSuccessState(addProductModel!));
      // print(addProductModel?.message);
    }
    )..catchError((error){
      print(error.toString());
      emit(AddProductErrorState(error));
    });
  }
/////////////////////////////////////
  GetProductModel ?getProductModel;
  void getProduct(
      { required String category,}
      ){
    emit(GetProductLoadingState());
    DioHelper.getData(url: 'getprod.php',
        query: {
          'category':category,
        }
    ).then((value){
      print("....................................................................");
      print(value.data);
      Map<String,dynamic>jsonData=json.decode(value.data);
      getProductModel=GetProductModel.fromJson(jsonData);
      emit(GetProductSuccessState(getProductModel!));
      print(value) ;}
    )..catchError((error){
      print(error.toString());
      emit(GetProductErrorState(error.toString()));
    });
  }

  // void addProduct({
  //   required String id,
  //   required String name,
  //   required String category,
  //   required String image,
  //   required double price,
  //   required String description,
  //   required String studentId,
  // }) {
  //   emit(AddProductLoadingState());
  //   ProductModel model=ProductModel(
  //       id: id,
  //       category: category,
  //       name: name,
  //       price: price,
  //       description: description,
  //       image: image,
  //       studentId: studentId,
  //   );
  //   FirebaseFirestore.instance.collection('products').add(
  //         model.toJson()).then((value)
  //   {
  //     emit(AddProductSuccessState());
  //   }
  //   ).catchError((error)
  //   {
  //     emit(AddProductErrorState());
  //   });
  //
  // }

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

  void addPost({
    required String studentId,
    required String text,
    required  String image,
    required Timestamp time,
    required int likes,
  })async
  {
    await DioHelper.postData(url: 'post.php', data:
    {
      'student_id':studentId,
      'text':text,
      'likes':likes,
      'time':time,
      'image':image,
    });
  }

  List<UserData> users=[];
  void getUsers() {
    users.clear();
    print('get users 11111111111');

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.id != FirebaseAuth.instance.currentUser!.uid)
          users.add(UserData.fromJson(element.data()));
      });

      print('get users 222222222');
      emit(GetUsersSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUsersErrorState());
    });
    print('get users 333333333333');
  }


  void sendMessage({
    required String receiverId,
    required String dateTime,
    required String text,
  })
  {
    MessageModel model= MessageModel(
        text: text,
        senderId: user!.uId,
        receiverId: receiverId,
        dateTime: dateTime
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((){
      emit(SendMessageErrorState());
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(user!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
    })
        .catchError((){
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> messages=[];
  void getMessages ({
    required String receiverId,
  })
  {
    emit(GetMessagesLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event)
    {
      messages=[];
      event.docs.forEach((element)
      {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessagesSuccessState());
    });
  }
}