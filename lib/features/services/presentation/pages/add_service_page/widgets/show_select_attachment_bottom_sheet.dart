import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

File? _video;
late VideoPlayerController videoPlayerController ;
final picker = ImagePicker();


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
                          //ConvertImage(imageFile!);

                          print(serviceImageFile!.path);
                        }else{
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

                        }).catchError((error){
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
                        }else{
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