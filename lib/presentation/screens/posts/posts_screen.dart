import 'package:flutter/material.dart';
import 'package:graduation/presentation/widgets/search_widget.dart';
import 'package:graduation/shared/widgets.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            search_widget(),
            SizedBox(
              height: 20,
            ),
            ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context,index)=>PostCard(),
              separatorBuilder: (context,index)=>SizedBox(
                height: 10,
              ),
              itemCount: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: Icon(
            Icons.add
        ),
      ),
    );
  }

  Widget PostCard() {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20,
          right: 20
      ),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: Colors.grey[500]!,
                width: 2
            ),
            borderRadius: BorderRadius.circular(
              20,
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    radius: 20,
                    child: Image(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "assets/images/man.png"
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AhmedMohamed',
                      ),
                      Text(
                          '3:30 PM'
                      ),
                    ],
                  ),
                  Spacer(),
                  TextButton(
                    onPressed: (){},
                    child: Text(
                        '+ Follow'
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, ...see more'
                ),
              ),
              myDivider(),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5,
                    left: 20
                ),
                child: Row(
                  children:
                  [
                    InkWell(
                      onTap: (){},
                      child: Row(
                        children:
                        [
                          Text(
                            'React',
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                              color: Colors.grey,
                              size: 15,
                              Icons.thumb_up_off_alt
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Row(
                        children:
                        [
                          Text(
                            'Comment',
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                              color: Colors.grey,
                              size: 15,
                              Icons.chat_outlined
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Row(
                        children:
                        [
                          Text(
                            'Repost',
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                              color: Colors.grey,
                              size: 15,
                              Icons.repeat_outlined
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: (){},
                      child: Row(
                        children:
                        [
                          Text(
                            'Send',
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                              color: Colors.grey,
                              size: 15,
                              Icons.send
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
