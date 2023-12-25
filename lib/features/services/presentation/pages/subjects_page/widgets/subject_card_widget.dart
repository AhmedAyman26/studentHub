import 'package:flutter/material.dart';
import 'package:graduation/common/styles/colors.dart';
import 'package:graduation/features/services/presentation/pages/service_types_page/service_types.dart';

class SubjectCardWidget extends StatelessWidget {
  static const routeName="service_screen";
  final String subjectName;

  const SubjectCardWidget({super.key, required this.subjectName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => ServiceTypesPage(subjectName: subjectName)),);
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height/8,
          child:  Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: AppColors.appGreen,
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
                  SizedBox (
                      width:MediaQuery.of(context).size.width/1.5,
                      child: Text(subjectName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:AppColors.appDarkGreen),)),

                ],
              ),
            ),
          ),
        )
    );
  }
}
