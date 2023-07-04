import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NewPostScreen extends StatelessWidget {
  //const NewPostScreen({Key? key}) : super(key: key);

  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GraduationCubit,GraduationStates>(
      listener: (context, state) {},
      builder: (context, state){
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
              icon:const Icon(Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            title: Text(
              AppLocalizations.of(context)!.create_post,
              style: TextStyle(
                  color: Colors.black
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color:const Color.fromRGBO(70, 121, 112, 1.0),
                  ),
                  child: TextButton(
                      onPressed: (){
                        var now = DateTime.now();
                        //print(now.toString());
                        // if (GraduationCubit.get(context).postImage == null ){
                        //   GraduationCubit.get(context).addPost(
                        //       studentId: "241",
                        //       text: textController.text,
                        //       image: "image",
                        //       dataTime: now.toString(),
                        //       likes: 5,
                        //   );
                        // }
                        GraduationCubit.get(context).addPost(
                          student_id: "241",
                          text: textController.text,
                          post_image: GraduationCubit.get(context).postImageLink,
                          time: now.toString(),
                          likes: 0,
                        );
                      },
                      child: Text(
                        AppLocalizations.of(context)!.post,
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          //backgroundColor: Colors.teal
                        ),
                      )
                  ),
                ),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('assets/images/man.png'),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${GraduationCubit.get(context).user?.fullname}',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),
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
                      hintText:  AppLocalizations.of(context)!.your_mind,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.broken_image,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                  AppLocalizations.of(context)!.add_photo
                              )
                            ],
                          )),
                    ),
                    // Expanded(
                    //   child: TextButton(
                    //       onPressed: (){},
                    //       child: Text(
                    //           "# tags"
                    //       )
                    //   ),
                    // ),
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
