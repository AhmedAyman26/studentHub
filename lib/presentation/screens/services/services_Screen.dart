import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:graduation/presentation/widgets/search_widget.dart';
import 'package:graduation/presentation/widgets/serviceCard_widget.dart';

class service_screen extends StatelessWidget {
  static const routeName="serviceCard_widget";
  List<String>name=[
    "programming", "Algorithms", "Theory of programming languages",
    "Compilers and language theory", "DirectX", "OpenGL", "Shell Scripting",
    "Python", "libavg", "pyOpenGL", "JavaScript", "jQuery", "PHP",
    "Ruby", "Java", "Web programming", "C", "Objective-C", "C++, NET", "Assembly",
    "VHDL", "Software/Application engineering",
    "Computer Graphics Programming", "Information theory", "Data compression",
    "Data structures", "Information security", "Information Management",
    "Networking", "Server administration", "Databases",
    "Operating Systems", "Artificial Intelligence", "Multimedia",
    "Scientific computing", "Graphic design with computers",
    "Web Services", "Design Physics", "Business process management",
    "Computational geometry", "Computational linguistics",
    "Digital Libraries", "Information systems",
    "Very Small Information Systems", "Nonkilling Technology",
    "Quantum computing", "Software freedom", "Device Utilization",
    "Parallel computing", "Concurrency and real-time programming",
    "Number Theory", "Statistics", "Graph theory",
    "Information theory", "Computer Science Theory","Iot",
    "embedded systems",
  ];

  Color green=Color.fromRGBO(70, 121, 112, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Column(
          children: [
            search_widget(),
            Expanded(
              child: ListView.builder(
                itemCount:name.length,
                itemBuilder: (context, index){
                  return serviceCard_widget(name[index]);
                },
              ),
            ),
          ],
        )
    );
  }

}
