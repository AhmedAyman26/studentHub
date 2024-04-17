import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:graduation/common/utils/constants/app_constants.dart';
import 'package:graduation/common/utils/cache_helper.dart';
import 'package:graduation/common/utils/constants/image_paths.dart';
import 'package:graduation/features/authentication/presentation/pages/login_page/login_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, const LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<OnBoardModel> onBoardData = [
      OnBoardModel(
        title: AppLocalizations.of(context)!.onboard_title1,
        description: "",
        imgUrl: ImagesPaths.onBoarding1,
      ),
      OnBoardModel(
        title: AppLocalizations.of(context)!.onboard_title2,
        description: "",
        imgUrl: ImagesPaths.onBoarding2,
      ),
      OnBoardModel(
        title: AppLocalizations.of(context)!.onboard_title3,
        description: "",
        imgUrl: ImagesPaths.onBoarding3,
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: OnBoard(
        pageController: _pageController,
        onSkip: () => submit(),
        onDone: () {
          // print('done tapped');
        },
        onBoardData: onBoardData,
        titleStyles: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
        ),
        descriptionStyles: TextStyle(
          fontSize: 16,
          color: Colors.brown.shade300,
        ),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: Color(0xff646060),
          activeColor: Color(0xfff4ba34),
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        skipButton: TextButton(
          onPressed: submit,
          child: Text(
            AppLocalizations.of(context)!.skip,
            style: const TextStyle(
                color: Color.fromRGBO(70, 121, 112, 1.0), fontSize: 18),
          ),
        ),
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                height: MediaQuery.of(context).size.height / 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(70, 121, 112, 1.0),
                      Color.fromRGBO(103, 139, 133, 1.0)
                    ],
                  ),
                ),
                child: Text(
                  state.isLastPage
                      ? AppLocalizations.of(context)!.sign_in
                      : AppLocalizations.of(context)!.next,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      submit();
    }
  }
}
