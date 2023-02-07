import 'package:flutter/material.dart';

import '../../../shared/appBar_class.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(110),
        child: AppBar(
         // backgroundColor: const Color.fromRGBO(70, 121, 112, 1.0),
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(0.5),
              child: Row(
                //mainAxisAlignment:  MainAxisAlignment.start,
                children:const [
                  Icon(
                    Icons.arrow_back_ios,
                    size: 19,
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=2048x2048&w=is&k=20&c=FLq43kh338qFN_JQSc262aRvFPBVlgDqhrG-sUtIIB8='
                    ),
                  )
                ],
              ),
            ),
          ),
          title: Container(
            margin:const EdgeInsets.all(7),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children:const [
                Text('Mohamed Osama',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(onPressed: (){},
              icon:const Icon(
                Icons.phone,
              ),
            ),
            IconButton(onPressed: (){},
              icon:const Icon(
                Icons.more_vert,
                size: 30,
              ),
            )
          ],
          toolbarHeight: MediaQuery.of(context).size.height/11,
          backgroundColor:Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipPath(
            clipper: CustomAppBarShape(
            ),
            child: Stack(
              alignment:Alignment.center ,
              children: [
                Container(
                  color:const Color.fromRGBO(70, 121, 112, 1.0),
                  alignment: Alignment.center,
                  // child: Text(
                  //   "title",style: TextStyle(color: Colors.white,fontSize: 20),),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(10),
                            topEnd: Radius.circular(10),
                            topStart: Radius.circular(10),
                          )
                      ),
                      padding:const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child:const Text(
                        'Hello',
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[400] ,
                          borderRadius:const BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(10),
                            topEnd: Radius.circular(10),
                            topStart: Radius.circular(10),
                          )
                      ),
                      padding:const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child:const Text(
                        'Hello',
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius:const BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(10),
                            topEnd: Radius.circular(10),
                            topStart: Radius.circular(10),
                          )
                      ),
                      padding:const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child:const Text(
                        'Where are U from?',
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[400] ,
                          borderRadius:const BorderRadiusDirectional.only(
                            bottomStart: Radius.circular(10),
                            topEnd: Radius.circular(10),
                            topStart: Radius.circular(10),
                          )
                      ),
                      padding:const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      child:const Text(
                        'From Egypt',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-60,
                    child: Card(
                      margin:const EdgeInsets.only(
                          left: 2,
                          right: 2,
                          bottom: 8 ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.multiline,
                        cursorColor: const Color.fromRGBO(70, 121, 112, 1.0),
                        maxLines: 5,
                        minLines: 1,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write a message..',
                          prefixIcon: IconButton(
                            color:const Color.fromRGBO(70, 121, 112, 1.0) ,
                            icon:const Icon(
                              Icons.emoji_emotions_outlined,
                            ),
                            onPressed: (){},
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(onPressed: ()
                              {
                                showModalBottomSheet(
                                    backgroundColor: Colors.transparent,
                                    context: context,
                                    builder: (builder) => bottomsheet() );

                              },
                                icon:const Icon(
                                  Icons.attach_file,
                                ),
                                color:const Color.fromRGBO(70, 121, 112, 1.0) ,
                              ),
                              IconButton(onPressed: (){},
                                icon:const Icon(
                                  Icons.camera_alt,
                                ),
                                color:const Color.fromRGBO(70, 121, 112, 1.0) ,
                              ),
                            ],
                          ),
                          contentPadding:const EdgeInsets.all(5),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 8,
                      left: 2,
                      right: 5,
                    ),
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor:const Color.fromRGBO(70, 121, 112, 1.0) ,
                      child: IconButton(
                        icon:const Icon(Icons.mic,
                          color: Colors.white,
                        ),
                        onPressed: (){},
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomsheet(){
    return Container(
      height: 278,
      width: 250,
      child: Card(
        margin:const EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 20
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  iconcreation(Icons.insert_drive_file, Colors.indigo, 'Document'
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.camera_alt, Colors.pink, 'Camera'
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.photo, Colors.purple, 'Gallery'
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  iconcreation(Icons.headset, Colors.orange, 'Audio'
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.location_pin, Colors.teal, 'Location'
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  iconcreation(Icons.person, Colors.blue, 'Contact'
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iconcreation(IconData icon, Color color, String text){
    return InkWell(
      onTap: (){},
      child: Column(
        children: [
          CircleAvatar(
            radius:30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style:const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}