import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../login/login_screen.dart';
class onBoard extends StatefulWidget {
  @override
  State<onBoard> createState() => _onBoardState();
}

class _onBoardState extends State<onBoard> {
  Widget dotPageView(){
    return Builder(builder: ((context){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        for(int i=0;i<3;i++)
          Padding(
            padding:const EdgeInsets.all(8.0),
            child:i== pageNumber ? Icon(Icons.circle,size: 10,color:Color(0xfff4ba34)) : Icon(Icons.circle_outlined,size: 10,color:Color(0xff467970),
            ),)
      ],);

    }));
  }

  Widget button(String title){
    return Builder(builder: ((context){
      return Container(
        height: MediaQuery.of(context).size.height/17,
        width: MediaQuery.of(context).size.width/1.5,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:Color(0xff467970),
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color:Color(0xff707070),),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0,
              blurRadius: 22,
              offset: Offset(0, 5),
              // changes position of shadow
            ),
          ],
        ),
        child:Text("$title",
          style: TextStyle(fontSize: 30,color: Colors.white),),
      );
    }));
  }

  PageController nextPage =PageController();

  int pageNumber=0;

  late String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        onPageChanged: (value){
         setState((){
           pageNumber=value;
           print(value);
         });
        },
        controller: nextPage,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
             SizedBox(
                height:1
              ),
              Image.asset("assets/images/undraw_Sharing_articles_re_jnkp.png"),
              Text (textAlign:TextAlign.center,
                "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.Ut vel\nturpis sit amet elit varius\nmalesuada. Mauris feugiat ligula\nvel purus posuere ultricies.",
                style: TextStyle(fontSize: 20,),),
              InkWell(
                onTap: (){
                  nextPage.animateToPage(1, duration: Duration(milliseconds:700), curve: Curves.easeIn);
                },
                child: button("Next"),
              ),
              dotPageView(),

            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height:1
              ),
              Image.asset("assets/images/undraw_sharing_knowledge_03vp (3).png"),
              Text (textAlign:TextAlign.center,
                "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.Ut vel\nturpis sit amet elit varius\nmalesuada. Mauris feugiat ligula\nvel purus posuere ultricies.",
                style: TextStyle(fontSize: 20,),),
              InkWell(
                onTap: (){
                  nextPage.animateToPage(2, duration:const Duration(milliseconds:700), curve: Curves.easeIn);
                },
                child: button("Next"),
              ),
              dotPageView(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                  height:1
              ),
              Image.asset("assets/images/undraw_Social_sharing_re_pvmr (2).png"),
              Text (textAlign:TextAlign.center,
                "Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit.Ut vel\nturpis sit amet elit varius\nmalesuada. Mauris feugiat ligula\nvel purus posuere ultricies.",
                style:TextStyle(fontSize: 20,),),
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => LoginScreen()));
                },
                child: button("Sign up"),
              ),
              dotPageView(),
            ],
          ),
        ],
      ),
    );
  }
}
