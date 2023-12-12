import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/models/ServiceModel.dart';
import 'package:graduation/data/models/addProduct_model.dart';
import 'package:graduation/data/models/getProduct_model.dart';
import 'package:graduation/data/models/message_model.dart';
import 'package:graduation/data/models/subject_model.dart';
import 'package:graduation/data/models/user_model.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/logic/cubit/states.dart';
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
        .doc(CacheHelper.getData(key: 'uId'))
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
    const DropdownMenuItem(
      value: 1,
      child: Text('Devices'),
    ),
    const DropdownMenuItem(
      value: 2 ,
      child: Text('Books'),
    ),
    const DropdownMenuItem(
      value: 3 ,
      child: Text('Electronic tools'),
    ),
    const DropdownMenuItem(
      value: 4 ,
      child: Text('Engineering tools'),
    ),
    const DropdownMenuItem(
      value: 5 ,
      child: Text('Medical tools'),
    ),
    const DropdownMenuItem(
      value: 6 ,
      child: Text('Chemical tools'),
    ),
    const DropdownMenuItem(
      value: 7 ,
      child: Text('Others'),
    ),
  ];
  List<DropdownMenuItem> Universityitems = [
    const DropdownMenuItem(
      value: 'Zagaizg University',
      child: Text('Zagaig University'),
    ),
    const DropdownMenuItem(
      value: 'Mansoura University',
      child: Text('Mansoura University'),
    ),
  ];
  List<DropdownMenuItem> subjectItems =const [
    DropdownMenuItem(
      value: '1',
      child: Text('programming'),
    ),
    DropdownMenuItem(
      value: '2',
      child: Text('Algorithms'),
    ),
    DropdownMenuItem(
      value: '3',
      child: Text('Theory of programming languages '),
    ),
    DropdownMenuItem(
      value: '4',
      child: Text('Compilers and language theory'),
    ),
    DropdownMenuItem(
      value: '5',
      child: Text('DirectX'),
    ),
    DropdownMenuItem(
      value: '6',
      child: Text('OpenGL'),
    ),
    DropdownMenuItem(
      value: '7',
      child: Text('Shell Scripting'),
    ),
    DropdownMenuItem(
      value: '8',
      child: Text('Python'),
    ),
  ];



////////////////////////////////////////////////////////
  int? selectedItem;
  changeSelectedItem(value) {
    selectedItem = value;
    emit(ChangeSelectedItemState());
  }

  String? selectedSubject;
  changeSelectedSubject(value) {
    selectedSubject = value;
    emit(ChangeSelectedItemState());
  }

  var productImagePicker = ImagePicker();
  File? file;
  String ?imageToAPI;
  String? link;

  Future showProductBottomSheet(context) async{
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please Choose Image',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  var picked =
                  await productImagePicker.pickImage(source: ImageSource.gallery);
                  if (picked != null) {
                    file = File(picked.path);
                    var imageName = basename(picked.path);
                    // convertImageToBase64(picked as File);
                    // imageToAPI =await convertImageToBase64(file!);
                    await FirebaseStorage.instance.ref()
                        .child('products/${Uri.file(file!.path).pathSegments.last}')
                        .putFile(file!).then((value)  {
                      value.ref.getDownloadURL().then((value) {
                        print(value);
                        link=value;
                        // emit(SocialUploadProfileImageSuccessState());
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: const Row(
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
                    // convertImageToBase64(picked as File);
                    await FirebaseStorage.instance.ref()
                        .child('products/${Uri.file(file!.path).pathSegments.last}')
                        .putFile(file!).then((value)  {
                      value.ref.getDownloadURL().then((value) {
                        print(value);
                        link=value;
                        // emit(SocialUploadProfileImageSuccessState());
                      });
                    });
                    // imageToAPI =await convertImageToBase64(file!);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: const Row(
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
        padding: const EdgeInsets.all(20),
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
                          var picked  = await ImagePicker().pickImage(source: ImageSource.gallery);
                          if(picked != null){
                            serviceImageFile = File(picked.path);
                            var imageName = basename(picked.path);
                            serviceImageToAPI =await convertImageToBase64(serviceImageFile!);
                            //ConvertImage(imageFile!);

                            print(serviceImageFile!.path);
                            emit(AddServiceImageSuccessState());
                          }else{
                            emit(AddServiceImageErrorState());
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: const Row(
                            children:[
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
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: const Row(
                            children:[
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
                          padding: const EdgeInsets.all(10),
                          child: const Row(
                            children:[
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
                          final video = await picker.getVideo(source: ImageSource.gallery);
                          _video = File(video!.path) ;
                          videoPlayerController = VideoPlayerController.file(_video!)..initialize().then((value) {
                            videoPlayerController.play();
                            convertImageToBase64(_video!);
                            emit(AddVideoSuccessState());
                          }).catchError((error){
                            emit(AddVideoErrorState(error.toString()));
                          });
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: const Row(
                            children:[
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
                            serviceImageToAPI =await convertImageToBase64(serviceImageFile!);
                            //ConvertImage(imageFile!);
                            emit(AddServiceImageSuccessState());
                          }else{
                            emit(AddServiceImageErrorState());
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(10),
                          child: const Row(
                            children:[
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
  ////////////////////////////////
////////////////////////////////
  Future<String> convertImageToBase64(File imageFile) async {
    List<int> imageBytes = await imageFile.readAsBytes();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }


////////////////////////////////

  AddProductModel?addProductModel;
  Future<void> addProduct({
    required String productName,
    //required int category_id,
    required String productImage,
    required String price,
    required String productDesc,
    String? studentId,
    required String? firebaseId,
  }) async {
    emit(AddProductLoadingState());

    await DioHelper.postData(url: 'product.php',
        data:{
          'student_id': studentId,
          'product_name':productName,
          'product_image':productImage,
          'product_desc':productDesc,
          'category_id':selectedItem,
          //category_id,
          //GraduationCubit().changeSelectedItem(value).toString(),
          'price':price,
          'firebase_id':firebaseId

        }).then((value)
    {
      print(value.data);
      Map<String,dynamic>JsonData=json.decode(value.data);
      addProductModel=AddProductModel.fromJson(JsonData);
      emit(AddProductSuccessState(addProductModel!));
      print(addProductModel?.message);
    }
    );
  }
/////////////////////////////////////
  GetProductModel ?getProductModel;
  void getProduct(
      { required String category,}
      )async{
    emit(GetProductLoadingState());
    await DioHelper.getData(url: 'getprod.php',
        query: {
          'category':category,
        }
    ).then((value){
      print("....................................................................");
      print(value.data);
      getProductModel=GetProductModel.fromJson(jsonDecode(value.data));
      emit(GetProductSuccessState(getProductModel!));}
    ).catchError((error){
      emit(GetProductErrorState(error.toString()));
    });
  }


  List<UserData> users=[];
  void getUsers() {
    users.clear();
    print('get users 11111111111');

    FirebaseFirestore.instance.collection('users').get().then((value) {
      value.docs.forEach((element) {
        if (element.id != FirebaseAuth.instance.currentUser!.uid) {
          users.add(UserData.fromJson(element.data()));
        }
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
    String? image,
  })async
  {
    MessageModel model= MessageModel(
        text: text,
        senderId: user!.uId,
        receiverId: receiverId,
        dateTime: dateTime,
        image: image
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value){
      emit(SendMessageSuccessState());
      emit(GetProductSuccessState(getProductModel!));
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
      emit(AddProductErrorState(error.toString()));
    }
    // Map<String,dynamic>JsonData=json.decode(value.data);
    // serviceModel=ServiceModel.fromJson(JsonData);

  }

  var postImagePicker = ImagePicker();
  File? postImageFile;
  String? postImageLink;
  Future showPostBottomSheet(context) async{
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please Choose Image',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () async {
                  var picked =
                  await postImagePicker.pickImage(source: ImageSource.gallery);
                  if (postImageFile != null) {
                    postImageFile = File(picked!.path);
                    var imageName = basename(picked.path);
                    // convertImageToBase64(picked as File);
                    // imageToAPI =await convertImageToBase64(file!);
                    await FirebaseStorage.instance.ref()
                        .child('posts/${Uri.file(file!.path).pathSegments.last}')
                        .putFile(postImageFile!).then((value)  {
                      value.ref.getDownloadURL().then((value) {
                        postImageLink=value;
                        // emit(SocialUploadProfileImageSuccessState());
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: const Row(
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
                  await postImagePicker.pickImage(source: ImageSource.camera);
                  if (picked != null) {
                    postImageFile = File(picked.path);
                    var imageName = basename(picked.path);
                    // convertImageToBase64(picked as File);
                    await FirebaseStorage.instance.ref()
                        .child('posts/${Uri.file(postImageFile!.path).pathSegments.last}')
                        .putFile(postImageFile!).then((value)  {
                      value.ref.getDownloadURL().then((value) {
                        postImageLink=value;
                        // emit(SocialUploadProfileImageSuccessState());
                      });
                    });
                    // imageToAPI =await convertImageToBase64(file!);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: const Row(
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






  List<DropdownMenuItem<Map<String,dynamic>>> subItems=[];
  SubjectModel? subModel;
  List<Map<String,dynamic>> subjects=[];
  void getSubj(int id)async
  {
    await DioHelper.getData(url: 'getsubj.php',query: {'faculty_id':1}).then((value)
    {
      subModel=SubjectModel.fromJson(jsonDecode(value.data));
      subjects=subModel!.subjects!.map((e) => e.toJson()).toList();
      subItems = subjects.map<DropdownMenuItem<Map<String, dynamic>>>((subject) {
        return DropdownMenuItem<Map<String, dynamic>>(
          value: subject,
          child: Text(subject['subject_name']),
        );
      }).toList();
    });
  }

}
