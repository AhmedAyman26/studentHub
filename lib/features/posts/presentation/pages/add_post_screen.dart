import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/posts/domain/models/create_post_input.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_cubit.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class CreatePostPage extends StatelessWidget {
  const CreatePostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsCubit(),
      child: CreatePostPageBody(),
    );
  }
}

class CreatePostPageBody extends StatelessWidget {
  CreatePostPageBody({Key? key}) : super(key: key);

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostsStates>(
      listener: (context, state)
      {
        if(state is CreatePostSuccessStates)
        {
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            titleSpacing: 5.0,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Text(
              AppLocalizations.of(context)!.create_post,
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: const Color.fromRGBO(70, 121, 112, 1.0),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        var now = DateTime.now();
                        await PostsCubit.get(context).addPost(CreatePostInput(
                          postImage: postImageLink,text: textController.text,
                          studentId: "366",time: now.toString()
                        ));
                      },
                      child: Text(
                        AppLocalizations.of(context)!.post,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          //backgroundColor: Colors.teal
                        ),
                      )),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                state is CreatePostLoadingStates?const LinearProgressIndicator():SizedBox(),
                const Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/man.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('',
                            // '${GraduationCubit.get(context).user?.fullname}',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.your_mind,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            showPostBottomSheet(context);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.broken_image,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(AppLocalizations.of(context)!.add_photo)
                            ],
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
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
                      .child('posts/${Uri.file(postImageFile!.path).pathSegments.last}')
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