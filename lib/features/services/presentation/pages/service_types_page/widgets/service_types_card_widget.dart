import 'package:flutter/material.dart';
import 'package:graduation/common/constants.dart';
import 'package:graduation/common/styles/colors.dart';
import 'package:graduation/features/services/presentation/pages/Single_categoty_service_screen.dart';
class ServiceTypesCardWidget extends StatelessWidget {

  final String serviceTypeImage;
  final String serviceTypeName;

  const ServiceTypesCardWidget({super.key, required this.serviceTypeImage, required this.serviceTypeName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: ()
        {
          navigateTo(context, ServicesPage(serviceType: serviceTypeName,));
        },
        child: Container(
          margin: const EdgeInsets.all(2),
          height: MediaQuery.of(context).size.height/6.5,
          child:  Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: AppColors.appGreen,
                  width: 0.5,
                )
            ),
            shadowColor: Colors.grey,
            elevation: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                  child: Image.asset(
                      serviceTypeImage,
                      height: MediaQuery.of(context).size.height/6.5,
                      width: MediaQuery.of(context).size.width/2.3,
                      fit:BoxFit.fill

                  ),
                ),
                Container (alignment: Alignment.center,
                    width:MediaQuery.of(context).size.width/2.3 ,
                    child: Text(serviceTypeName,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color:AppColors.appDarkGreen),)),

              ],
            ),
          ),
        )
    );
  }
}
