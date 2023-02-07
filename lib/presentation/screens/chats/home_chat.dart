import 'package:flutter/material.dart';
import 'package:graduation/presentation/screens/chats/chat_screen.dart';
import 'package:graduation/presentation/widgets/search_widget.dart';

import '../../../shared/appBar_class.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(110),
        child: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon:const Icon(
                Icons.arrow_back,
              size: 28,
            ),
          ),
          title: Container(
            margin:const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:const [
                Text(
                  'Chat',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(onPressed: (){},
              icon:const Icon(Icons.more_vert,
                size: 30,
              ),
            )
          ],
          toolbarHeight: MediaQuery.of(context).size.height/10,
          backgroundColor:Colors.transparent,
          elevation: 0,
          flexibleSpace: ClipPath(
            clipper: CustomAppBarShape(),
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            search_widget(),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>const ChatScreen(),
                  ),
                );
              },
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://media.istockphoto.com/id/1270067126/photo/smiling-indian-man-looking-at-camera.jpg?s=2048x2048&w=is&k=20&c=FLq43kh338qFN_JQSc262aRvFPBVlgDqhrG-sUtIIB8='
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mohamed Osama',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children:const [
                            Expanded(
                              child: Text(
                                'From Egypt ',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: 10
                              ),
                            ),
                            Text(
                              '02:00 pm',
                            ),
                          ],
                        ),
                      ],
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
}
