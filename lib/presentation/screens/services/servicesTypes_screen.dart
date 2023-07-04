import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graduation/presentation/widgets/servicesTypesCard_Widget.dart';
import 'package:graduation/shared/appBar_class.dart';
import 'package:graduation/presentation/widgets/productCard_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class servicesTypes_screen extends StatelessWidget {
  static const routeName="servicesTypes_screen";
  String title;
  servicesTypes_screen(this.title);

  List<String>image=["assets/images/pdf.png","assets/images/undraw_link_shortener_mvf6.png",
  "assets/images/undraw_Images_re_0kll.png","assets/images/undraw_video_files_fu10.png","assets/images/summary.png"];
  @override
  Widget build(BuildContext context) {
    List<String>name=["PDF",AppLocalizations.of(context)!.links,
      AppLocalizations.of(context)!.images,
    AppLocalizations.of(context)!.videos,
    AppLocalizations.of(context)!.summarization,];
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height/6,
        backgroundColor:Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: CustomAppBarShape(),
          child: Stack(
            alignment:Alignment.center ,
            children: [

              Container(
                color:Color.fromRGBO(70, 121, 112, 1.0),
                alignment: Alignment.center,
                child: Text(title,style: TextStyle(color: Colors.white,fontSize: 20),),
              ),


            ],
          ),
        ),

      ),
      body:  ListView.builder(
        itemCount:name.length,
        itemBuilder: (context, index){
          return servicesTypesCard_Widget(image[index], name[index]);
        },
      ),
    );
  }
}
