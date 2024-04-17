import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AppSearchWidget extends StatefulWidget {

  const AppSearchWidget({super.key});

  @override
  State<AppSearchWidget> createState() => _AppSearchWidgetState();
}

class _AppSearchWidgetState extends State<AppSearchWidget> {
  Color green=const Color.fromRGBO(103, 139, 133, 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      width:MediaQuery.of(context).size.width/1.4,
      margin: const EdgeInsets.only(bottom: 5),
      height:35,
      child: TextField(
        style: const TextStyle(
            color: Colors.grey,
            fontSize: 15
        ),
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
            prefixIcon:const Icon(Icons.search, size: 25, color:Colors.grey ,),
            hintText:AppLocalizations.of(context)!.search ,
            hintStyle: const TextStyle(color:Colors.grey,fontSize:15,)
        ),
      ),
    );
  }
}
