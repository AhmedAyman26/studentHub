import 'dart:io';
// ignore_for_file: deprecated_member_use
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/logic/cubit/cubit.dart';
import 'package:graduation/logic/cubit/states.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
//دا الي انا شغال عليه
class AddService extends StatefulWidget {
  AddService();

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {

  TextEditingController serviceNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>GraduationCubit(),
      child: BlocConsumer<GraduationCubit, GraduationStates>(
        listener: (context, state){
          if(state is AddServiceSuccessState){
            // if(state.serviceModel.success==true) {
            //   Navigator.of(context).pop();
            // }
          }
          else{print("-------------------------");}
        },
        builder: (context , state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 5.0,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon:const Icon(Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title:const Text(
                'Add Service',
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
                        onPressed: () async{
                          if(state is AddServiceLoadingState){
                            Center(child: CircularProgressIndicator());
                          }else
                          {

                            GraduationCubit.get(context).addService(
                                serviceName: serviceNameController.text,
                                serviceType: '1',
                                subjectId: '1',
                                studentId: "241",
                                attachment: "",
                                inFavourite: "true"
                            );
                          }
                        },
                        child:const Text(
                          'Post',
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
              padding: const EdgeInsets.all(20.0),
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
                              '${FirebaseAuth.instance.currentUser?.displayName??'default'}',
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
                  const SizedBox(
                    height: 18,
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: SingleChildScrollView(
                      child: DropdownButton(
                        icon:const Icon(Icons.keyboard_arrow_down_rounded),
                        items: GraduationCubit.get(context).subjectItems/*.take(7).toList()*/,
                        hint:const Text('Select Subject'),
                        onChanged: (val) {
                          GraduationCubit.get(context).changeSelectedItem(val);
                        },
                        isExpanded: true,
                        value: GraduationCubit.get(context).selectedItem,
                      ),
                    ),
                  ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    controller: serviceNameController ,
                    cursorColor: Colors.teal,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Type your description...',
                      border: InputBorder.none,
                      fillColor: Colors.teal,
                    ),

                  ),
                  Expanded(
                    child: Container(
                      // width: 300,
                      // height: 300,
                      child:Center(
                        child: GraduationCubit.get(context).
                        serviceImageFile == null ?  Text('not Found')  : Image.file(GraduationCubit.get(context).serviceImageFile! ,
                          width: 250,
                          height: 250,
                        ) ,
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:const Color.fromRGBO(70, 121, 112, 1.0),
                        ),
                        child: TextButton(
                          onPressed: () => GraduationCubit.get(context).showServiceBottomSheet(context),
                          child: const Text(
                            'UPLOAD',
                            style: TextStyle(
                              color: Colors.white,
                              //color: Color.fromRGBO(70, 121, 112, 1.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

