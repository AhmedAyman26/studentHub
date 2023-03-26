import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: Column(
          children:
          [
            Stack(
              children:
              [
                Image(
                  image: AssetImage("assets/images/path.png"),
                ),
                Align(child: IconButton(onPressed: (){}, icon: Icon(Icons.person,size:35,color: Colors.white,),),alignment: Alignment.topLeft,),
                Align(child: IconButton(onPressed: (){}, icon: Icon(Icons.chat,size: 35,color: Colors.white,),),alignment: Alignment.topRight,)
              ],
            )
          ],
        ),
      ),
      // appBar: AppBar(
      //   actions: [
      //     IconButton(onPressed: (){}, icon: Icon(
      //       Icons.ac_unit_sharp
      //     ))
      //   ],
      //     leading:Icon(Icons.person,size: 30,),
      //     toolbarHeight: 150,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   flexibleSpace: ClipPath(
      //     clipper: CustomAppBarShape(),
      //     child: Container(
      //       color: HexColor('#678B85'),
      //     ),
      //   ),
      // ),
    );
  }
}


class Customshape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0, height-50);
    path.quadraticBezierTo(width/2, height, width, height-50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}


class CustomAppBarShape extends CustomClipper<Path> {


  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height*0.5);
    path.quadraticBezierTo(size.width*0.005, size.height*0.8, size.width*0.3, size.height*0.8);
    path.lineTo(size.width*0.8, size.height*0.8);
    path.quadraticBezierTo(size.width, size.height*0.8, size.width,size.height);
    path.lineTo(size.width, 0);
    // path.lineTo(0, size.height*0.5);
    // path.quadraticBezierTo(size.width*0.05, size.height, size.width*0.9, size.height*0.8);
    // path.quadraticBezierTo(size.width+5, size.height*0.8, size.width, size.height);
    // path.lineTo(size.width, 0);

    return path;
  }

  @override

  bool shouldReclip (CustomClipper<Path> oldClipper)
  {
    return false;
  }
}


