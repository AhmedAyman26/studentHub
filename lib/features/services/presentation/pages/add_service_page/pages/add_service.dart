import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/cubits/user_cubit/user_cubit.dart';
import 'package:graduation/features/services/presentation/pages/add_service_page/pages/add_service_cubit.dart';
import 'package:graduation/features/services/presentation/pages/add_service_page/pages/add_service_state.dart';
import 'package:graduation/features/services/presentation/pages/add_service_page/widgets/show_select_attachment_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});


  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {

  TextEditingController serviceNameController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AddServiceCubit(),
      child: BlocConsumer<AddServiceCubit, AddServiceState>(
        listener: (context, state){
        },
        builder: (context , state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 5.0,
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon:const Icon(Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                AppLocalizations.of(context)!.add_service,
                style: const TextStyle(
                    color: Colors.black
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color:const Color.fromRGBO(70, 121, 112, 1.0),
                    ),
                    child: TextButton(
                        onPressed: () async{
                          if(true){
                            const Center(child: CircularProgressIndicator());
                          }else
                          {

                            // GraduationCubit.get(context).addService(
                            //     serviceName: serviceNameController.text,
                            //     serviceType: '1',
                            //     subjectId: '1',
                            //     studentId: "241",
                            //     attachment: "",
                            //     inFavourite: "true"
                            // );
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.post,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Colors.white,
                            //backgroundColor: Colors.teal
                          ),
                        )
                    ),
                  ),
                )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                       CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(UserCubit.get(context).state.userData?.image??''),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              UserCubit.get(context).state.userData?.fullName??'',
                              style:  TextStyle(
                                  fontSize: 18.sp
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  // Container(
                  //   padding:  EdgeInsets.only(top: 10.h),
                  //   child: SingleChildScrollView(
                  //     child: DropdownButton(
                  //       icon:const Icon(Icons.keyboard_arrow_down_rounded),
                  //       items: GraduationCubit.get(context).subjectItems/*.take(7).toList()*/,
                  //       hint: Text(AppLocalizations.of(context)!.select_subject),
                  //       onChanged: (val) {
                  //         GraduationCubit.get(context).changeSelectedSubject(val);
                  //       },
                  //       isExpanded: true,
                  //       value: GraduationCubit.get(context).selectedSubject,
                  //     ),
                  //   ),
                  // ),
                  TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    controller: serviceNameController ,
                    cursorColor: Colors.teal,
                    keyboardType: TextInputType.multiline,
                    decoration:  InputDecoration(
                      hintText: AppLocalizations.of(context)!.type_description,
                      border: InputBorder.none,
                      fillColor: Colors.teal,
                    ),

                  ),
                  // Expanded(
                  //   child: Center(
                  //     child: GraduationCubit.get(context).
                  //     serviceImageFile == null ?  Text(AppLocalizations.of(context)!.not_found)  : Image.file(GraduationCubit.get(context).serviceImageFile! ,
                  //       width: 250,
                  //       height: 250,
                  //     ) ,
                  //   ),
                  // ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color:const Color.fromRGBO(70, 121, 112, 1.0),
                        ),
                        child: TextButton(
                          onPressed: () => showServiceBottomSheet(context),
                          child:  Text(
                            AppLocalizations.of(context)!.upload,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}

