import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:graduation/presentation/screens/services/servicesTypes_screen.dart';

class serviceCard_widget extends StatelessWidget {
  static const routeName="service_screen";
  String name;
  serviceCard_widget(this.name);
  Color green=Color.fromRGBO(70, 121, 112, 1.0);
  Color darkGreen=Color.fromRGBO(70, 121, 112, 1.0);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => servicesTypes_screen("$name")),);
        },
        child: Container(
          margin: EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height/8,
          child:  Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: green,
                  width: 0.5,
                )
            ),
            shadowColor: Colors.grey,
            elevation:5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container (
                      width:MediaQuery.of(context).size.width/1.5,
                      child: Text("$name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:darkGreen),)),

                ],
              ),
            ),
          ),
        )
    );
  }
}
