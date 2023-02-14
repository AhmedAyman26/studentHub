import 'package:flutter/material.dart';

class AddService extends StatelessWidget {
   AddService({Key? key}) : super(key: key);

  TextEditingController description = TextEditingController();



  @override
  Widget build(BuildContext context) {
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
                  onPressed: (){},
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
                    children:const [
                       Text(
                        'Mohamed Osama',
                        style: TextStyle(
                          //fontWeight: FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      // ListView(
                      //   children: [
                      //     DropdownButton(
                      //       value: defaultValue,
                      //         menuMaxHeight: 350,
                      //         items: [
                      //           DropdownMenuItem(
                      //               child: Text(
                      //                 "select"
                      //               ),
                      //             value: ,
                      //           )
                      //
                      //         ],
                      //         onChanged: (){},
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Expanded(
              child: TextFormField(
                minLines: 1,
                maxLines: 5,
                controller: description ,
                cursorColor: Colors.teal,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Type your description...',
                  border: InputBorder.none,
                  fillColor: Colors.teal,
                ),
              ),
            ),
            Container(
              height: 230,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    IconButton(onPressed: (){},
                      icon:const Icon(
                        Icons.keyboard_arrow_up,
                      ),
                    ),
                    const Divider(
                      height:10 ,
                      color: Colors.grey,

                    ),
                    InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Post(), ) );
                      },
                      child: Row(
                        children:const [
                          // TextButton(onPressed:()=>print('live') ,
                          //   child: Icon(
                          //       Icons.video_call,
                          //     color: Colors.grey,
                          //   ),
                          //
                          // ),
                          Icon(Icons.photo_outlined,
                            color: Colors.grey,
                            size: 35,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text('Add Image',
                            style: TextStyle(
                              fontSize: 18,
                            ),),


                        ],
                      ),
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.grey,

                    ),
                    InkWell(
                      onTap: (){
                      },
                      child: Row(
                        children:const [
                          Icon(Icons.add_link_rounded,
                            color: Colors.grey,
                            size: 35,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text('Add Link',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.grey,

                    ),
                    // Row(
                    //   children: [
                    //     TextButton(onPressed:()=>print('live') ,
                    //
                    //       child: Icon(
                    //         Icons.video_call,
                    //         color: Colors.grey,
                    //       ),
                    //
                    //     ),
                    //     Text('data'),
                    //   ],
                    // ),
                    InkWell(
                      onTap: (){
                      },
                      child: Row(
                        children:const [
                          Icon(Icons.file_present,
                            color: Colors.grey,
                            size: 35,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text('Add PDF',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.grey,

                    ),
                    InkWell(
                      onTap: (){
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Post(), ) );
                      },
                      child: Row(
                        children:const[
                          Icon(Icons.video_camera_back_outlined,
                            color: Colors.grey,
                            size: 35,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text('Add Video',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 10,
                      color: Colors.grey,

                    ),
                    InkWell(
                      onTap: (){
                      },
                      child: Row(
                        children:const [
                          Icon(Icons.camera_alt_outlined,
                            color: Colors.grey,
                            size: 35,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text('Camera',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
