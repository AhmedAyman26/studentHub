import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:graduation/shared/constants.dart';
import 'package:graduation/shared/local/cache_helper.dart';

import '../login/login_screen.dart';
class OnBoardingScreen extends StatefulWidget {


  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  @override
  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value)
    {
      if(value)
      {
        navigateAndFinish(context, LoginScreen());
      }
    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: OnBoard(
        pageController: _pageController,
        onSkip: ()=>submit(),
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
          inactiveColor:Color(0xf646060),
          activeColor: Color(0xfff4ba34),
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),

        skipButton: TextButton(
          onPressed: submit,
          child: const Text(
            "Skip",
            style: TextStyle(color: Color.fromRGBO(70, 121, 112, 1.0),fontSize: 18),
          ),
        ),

        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: MediaQuery.of(context).size.width/1.5,
                height:MediaQuery.of(context).size.height/20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color.fromRGBO(70, 121, 112, 1.0), Color.fromRGBO(103, 139, 133, 1.0)],
                  ),
                ),
                child: Text(
                  state.isLastPage ? "Sign up" : "Next",
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

final List<OnBoardModel> onBoardData = [
  const OnBoardModel(
    title: "Exchange services with students from different universitres in your field of study including references, summerization, Links ,Online courses.",
    description: "",
    imgUrl: "assets/images/undraw_Sharing_articles_re_jnkp.png",
  ),
  const OnBoardModel(
    title: "We enable you to offer and request different products and tools used in different fields to achieve collaboration.",
    description: "",
    imgUrl: 'assets/images/undraw_sharing_knowledge_03vp (3).png',
  ),
  const OnBoardModel(
    title: "All students in the same platform so you can ask freely about any thing you need in the right place",
    description: "",
    imgUrl: 'assets/images/undraw_Social_sharing_re_pvmr (2).png',
  ),
];


