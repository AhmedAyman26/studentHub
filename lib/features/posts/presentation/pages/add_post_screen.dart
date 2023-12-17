import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/features/posts/domain/models/create_post_input.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_cubit.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:graduation/shared/utils.dart';
import 'package:graduation/shared/widgets.dart';

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

class CreatePostPageBody extends StatefulWidget {
  const CreatePostPageBody({Key? key}) : super(key: key);

  @override
  State<CreatePostPageBody> createState() => _CreatePostPageBodyState();
}

class _CreatePostPageBodyState extends State<CreatePostPageBody> {
  TextEditingController textController = TextEditingController();

  String? postImageLink;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsCubit, PostStates>(
      listener: (context, state)
      {
        if(state.createPostState==RequestStatus.success)
        {
          Navigator.of(context).pop();
        }
        if(state.createPostState==RequestStatus.error)
        {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('please try again'),backgroundColor: Colors.red,));
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
                state.createPostState==RequestStatus.loading?const LinearProgressIndicator():const SizedBox(),
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
                            showSelectImageBottomSheet(context, (image)async {
                              await FirebaseStorage.instance.ref()
                                  .child('posts/${Uri.file(image.path).pathSegments.last}')
                                  .putFile(image).then((value)  {
                                value.ref.getDownloadURL().then((value) {
                                  postImageLink=value;
                                  setState(() {
                                  });
                                });
                              });
                              Navigator.of(context).pop();
                            });
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
