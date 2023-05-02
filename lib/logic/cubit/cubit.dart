import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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
import '../../data/models/addProduct_model.dart';
import '../../data/models/getProduct_model.dart';

class GraduationCubit extends Cubit<GraduationStates> {
  var value;

  GraduationCubit() : super(GraduationInitialState());
  static GraduationCubit get(context) => BlocProvider.of(context);

  List<DropdownMenuItem> items = [
    DropdownMenuItem(
      child: Text('Devices'),
      value: '1',
    ),
    DropdownMenuItem(
      child: Text('Books'),
      value: '2',
    ),
    DropdownMenuItem(
      child: Text('Engineering tools'),
      value: '3',
    ),
    DropdownMenuItem(
      child: Text('Clothes'),
      value: '4',
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
  /////////////////////////////////////////////////////////////////////////////////////////
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


}
