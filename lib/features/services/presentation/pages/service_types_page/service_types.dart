import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation/common/utils/constants/image_paths.dart';
import 'package:graduation/features/services/presentation/pages/service_types_page/widgets/service_types_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceTypesPage extends StatelessWidget {
  static const routeName = "ServiceTypesPage";
  final String subjectName;

  final List<String> image = [
    ImagesPaths.pdf,
    ImagesPaths.link,
    ImagesPaths.image,
    ImagesPaths.video,
    ImagesPaths.summarization
  ];

  ServiceTypesPage({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    List<String> name = [
      "PDF",
      AppLocalizations.of(context)!.links,
      AppLocalizations.of(context)!.images,
      AppLocalizations.of(context)!.videos,
      AppLocalizations.of(context)!.summarization,
    ];
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Image(
                      width: double.infinity,
                      fit: BoxFit.fill,
                      image: AssetImage(ImagesPaths.chatHeader),
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 30.h),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.0.w),
                              child: InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: const Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.white,
                                  )),
                            ),
                            const Spacer(),
                            Text(
                              subjectName,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => ServiceTypesCardWidget(
                      serviceTypeImage: image[index],
                      serviceTypeName: name[index]),
                  childCount: image.length),
            ),
          ],
        ),
      ),
    );
  }
}
