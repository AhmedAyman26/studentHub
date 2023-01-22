import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
class search_widget extends StatelessWidget {
  Color green=Color.fromRGBO(103, 139, 133, 1.0);
  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width/1.4,
      height:35,
      child: TextField(
        style: TextStyle(
            color: Colors.grey,
            fontSize: 15
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),),
              borderSide: BorderSide(
                color: green,
                width: 1.0,),),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: green,
                width: 2.0,
              ),
            ),
            fillColor: Colors.transparent,
            prefixIcon:Icon(Icons.search, size: 25, color:Colors.grey ,),
            hintText: 'Search',
            hintStyle: TextStyle(color:Colors.grey,fontSize:15,)
        ),
      ),
    );
  }
}
