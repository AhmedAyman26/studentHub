import 'package:flutter/widgets.dart';

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