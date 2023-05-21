import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/ServiceModel.dart';
import 'package:graduation/data/models/Subjects_model.dart';
import 'package:graduation/data/models/addProduct_model.dart';
import 'package:graduation/data/models/getProduct_model.dart';
import 'package:graduation/data/models/message_model.dart';
import 'package:graduation/data/models/post_model.dart';
import 'package:graduation/data/models/product_model.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:graduation/logic/register_cubit/cubit.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';

class GraduationCubit extends Cubit<GraduationStates> {
  GraduationCubit() : super(GraduationInitialState());
  static GraduationCubit get(context) => BlocProvider.of(context);

  UserData? user;

  void getUserData() async {
    emit(GetUserDataLoadingState());
    await FirebaseFirestore.instance
        .collection('users')
        .doc(CacheHelper.getData(key: 'id'))
        .get()
        .then((value) {
      print("++++++++++++++");
      print(id);
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
  List<DropdownMenuItem> subjectItems =const [
    DropdownMenuItem(
      child: Text('programming'),
      value: '1',
    ),
    DropdownMenuItem(
      child: Text('Algorithms'),
      value: '2',
    ),
    DropdownMenuItem(
      child: Text('Theory of programming languages '),
      value: '3',
    ),
    DropdownMenuItem(
      child: Text('Compilers and language theory'),
      value: '4',
    ),
    DropdownMenuItem(
      child: Text('DirectX'),
      value: '5',
    ),
    DropdownMenuItem(
      child: Text('OpenGL'),
      value: '6',
    ),
    DropdownMenuItem(
      child: Text('Shell Scripting'),
      value: '7',
    ),
    DropdownMenuItem(
      child: Text('Python'),
      value: '8',
    ),
  ];


  String? selectedItem;
  changeSelectedItem(value) {
    selectedItem = value;
    emit(ChangeSelectedItemState());
  }

  var productImagePicker = ImagePicker();
  File? file;
  String ?imageToAPI;
  Future showProductBottomSheet(context) async{

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

  File? _video;
  late VideoPlayerController videoPlayerController ;
  final picker = ImagePicker();


  var imagePicker = ImagePicker();
  File? serviceImageFile ;
  String ?serviceImageToAPI;

  Future showServiceBottomSheet(context) async{

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 230,
                width: double.infinity,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () async{
                          // emit(AddImageLoadingState());
                          var picked  = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if(picked != null){
                            serviceImageFile = File(picked.path);
                            var imageName = basename(picked.path);
                            serviceImageToAPI =await ConvertImage(serviceImageFile!);
                            //ConvertImage(imageFile!);

                            print(serviceImageFile!.path);
                            emit(AddServiceImageSuccessState());
                          }else{
                            print("===+++++++++++++++++++");
                            emit(AddServiceImageErrorState());
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children:const [
                              Icon(
                                Icons.photo_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add Image',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.black,
                      ),
                      InkWell(
                        onTap: () async{
                          var dio =Dio();
                          FilePickerResult? result =await FilePicker.platform.pickFiles();

                          if(result!=null){
                            File file = File(result.files.single.path ?? "" );

                            String fileName = file.path.split('/').last;
                            String filePath = file.path;

                            ConvertFile(file);

                            // FormData data = FormData.fromMap({
                            //   'apiKey': 'apiKey',
                            //   'file': await MultipartFile.fromFile(filePath ,filename: fileName)
                            // });
                            //
                            // var response = dio.post(
                            //     "http://gradproj.atwebpages.com",
                            //     data: data,
                            // onSendProgress: (int sent, int total){
                            //       print('$sent $total');
                            // }
                            // );
                            // print(response.toString());
                          }else{
                            print("result is null");
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children:const [
                              Icon(
                                Icons.file_present,
                                color: Colors.grey,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add File',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.black,
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children:const [
                              Icon(
                                Icons.link,
                                color: Colors.grey,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add Link',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.black,
                      ),
                      InkWell(
                        onTap: ()async{
                          //emit(AddVideoLoadingState());
                          final video = await picker.getVideo(source: ImageSource.gallery);
                          _video = File(video!.path) ;
                          videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((value) {
                            videoPlayerController.play();
                            ConvertImage(_video!);
                            emit(AddVideoSuccessState());
                          }).catchError((error){
                            print(error.toString());
                            emit(AddVideoErrorState(error.toString()));
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children:const [
                              Icon(
                                Icons.video_camera_back_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Add Video',
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        height: 10,
                        color: Colors.black,
                      ),
                      InkWell(
                        onTap: ()async{
                          // emit(AddImageLoadingState());
                          var picked  = await ImagePicker().pickImage(source: ImageSource.camera);
                          if(picked != null){
                            serviceImageFile = File(picked.path);
                            var imageName = basename(picked.path);
                            serviceImageToAPI =await ConvertImage(serviceImageFile!);
                            //ConvertImage(imageFile!);

                            print(serviceImageFile!.path);
                            emit(AddServiceImageSuccessState());
                          }else{
                            print("===+++++++++++++++++++");
                            emit(AddServiceImageErrorState());
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            children:const [
                              Icon(
                                Icons.photo_outlined,
                                color: Colors.grey,
                                size: 30,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Camera',
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

            ],
          ),
        ),
      ),

    );
  }

  Future ConvertFile(File file)async {
    Uint8List fileBytes = await file.readAsBytes();
    String base64String = base64.encode(fileBytes);

    print(base64String);

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

  ServiceModel? serviceModel;
  void addService({
    required String serviceName,
    required String serviceType,
    required String subjectId,
    required String studentId,
    required String attachment,
    required String inFavourite,
  }) async{
    try{
      emit(AddServiceLoadingState());
    var res=await DioHelper.postData(
      url: 'service.php',
      data:
      {
        'student_id': studentId,
        'service_name':serviceName,
        'service_type':serviceType,
        'subject_id':subjectId,
        'attachment':attachment,
        'in_favourite':inFavourite,
      },
    );
    emit(AddServiceSuccessState());
      // model=ServiceModel.fromJson(value.data);
      // print(res.data);
    }catch(error)
    {
      print(error.toString());
      emit(AddProductErrorState(error.toString()));
    }
      // Map<String,dynamic>JsonData=json.decode(value.data);
      // serviceModel=ServiceModel.fromJson(JsonData);

    }
    List<Subjects> subjects=[];
    getSubjects({query})async
    {
      await DioHelper.getData(url: 'getsubj',query:query );
    }

  PostModel? postModel;
  void addPost({
    required String name,
    required String studentId,
    required String text,
    required String image,
    required String dataTime,
    required int likes,
  })async
  {
    emit(CreatePostLoadingStates());
    await DioHelper.postData(
        url: 'post.php',
        data: {
          'student_id':studentId,
          'name':name,
          'text':text,
          'likes':likes,
          'dataTime':dataTime,
          'image':image,
        }
    ).then((value){
      print(value.data);
      emit(CreatePostSuccessStates(postModel!));

    }).catchError((error){
      print(error.toString());
      emit(CreatePostErrorStates(error.toString()));
    });
  }


  List<PostModel> posts =[];
  void getPost()async{
    emit(GetPostLoadingStates());
    await DioHelper.getData(
      url: 'getpost.php',

    ).then((value)
    {
      final responseJson = jsonDecode(value.data) as Map<String ,dynamic >;
      //print(value);
      // print(value.data.runtimeType.toString()) ;
      final posts = (responseJson["posts"] as List)
          .map((e) => PostModel.fromJson(e as Map<String,dynamic>)).toList();
      this.posts = posts ;
      // posts.add(PostModel.fromJson(value.data));
      //print(value.posts);
      emit(GetPostSuccessStates());

    }).catchError((error){
      //throw error;
      print(error.toString());
      emit(GetPostErrorStates(error.toString()));
    });

  }

}