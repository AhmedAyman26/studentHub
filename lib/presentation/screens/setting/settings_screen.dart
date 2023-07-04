import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/shared/styles/colors.dart';
import '../../../logic/Language Cubit/language_cubit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String? language_status;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding:  EdgeInsets.all(20.0.h),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Padding(
          padding:  EdgeInsets.only(top:12.0.h),
          child: Text(AppLocalizations.of(context)!.settings,style: TextStyle(color: Colors.black,fontSize: 18.sp),),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(10.0.h),
        child: Column(
          children: [
            Row(
              children: [
                 CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  radius: 25.w,
                  child: Image(image: AssetImage('assets/images/user.png'))),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AhmedAyman',style: TextStyle(fontSize: 16.sp),),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text('Computer And Information',style: Theme.of(context).textTheme.bodySmall,)
                  ],
                ),
                Spacer(),
                IconButton(onPressed: (){}, icon: Icon(
                    Icons.arrow_forward_ios_outlined,
                   color: Colors.grey[600],
                ))
                ],
            ),
            ListTile(
              leading: ImageIcon(AssetImage('')),
            ),
            Padding(
              padding: EdgeInsets.only(right: 16,left: 16),
              child: ExpansionTile(
                collapsedIconColor: Colors.black,
                trailing:Icon(Icons.arrow_drop_down_outlined),
                iconColor:Colors.white,
                title: Row(
                  children: [
                    //Image.asset("assets/images/market.png",
                    // width: 21.3,
                    // height: 24,),
                    Icon(Icons.language,color: Colors.black,),
                    Text("   ${AppLocalizations.of(context)!.language}"),

                  ],
                ),
                childrenPadding: EdgeInsets.all(5),
                children: [
                  BlocBuilder<RadioListTileCubit, int>(
                      builder: (context, state) {
                        return Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(AppLocalizations.of(context)!.arabic),
                              activeColor: Color.fromRGBO(70, 121, 112, 1.0),
                              value: 1,
                              groupValue: state,
                              onChanged: (value){
                                context.read<RadioListTileCubit>().selectItem(value!);
                                context.read<LanguageCubit>()..changeLanguage('ar');
                              },
                            ),
                            RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Text(AppLocalizations.of(context)!.english),
                              value:0,
                              activeColor: Color.fromRGBO(70, 121, 112, 1.0),
                              groupValue: state,
                              onChanged: (value){
                                context.read<RadioListTileCubit>().selectItem(value!);
                                context.read<LanguageCubit>()..changeLanguage('en');
                              },
                            ),
                          ],
                        );
                      }),
                ],


              ),
            ),


          ],
        ),
      ),
    );
  }
}
