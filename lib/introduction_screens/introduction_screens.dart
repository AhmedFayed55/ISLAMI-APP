import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../home/home_screen.dart';
import 'intro_screen.dart';

class IntroductionScreens extends StatefulWidget {
  static const String routeName = "intro_screen";

  const IntroductionScreens({super.key});

  @override
  State<IntroductionScreens> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<IntroductionScreens> {
  String buttonText1 = "Back";
  String buttonText2 = "Next";
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              if (index == 4) {
                buttonText2 = "Finish";
              } else if (index == 0) {
                buttonText1 = '';
              } else {
                buttonText1 = "Back";
                buttonText2 = "Next";
              }
              setState(() {});
            },
            children: [
              IntroScreen(
                imagePath: "assets/images/welcome.png",
                text1: "",
                text2: "Welcome To Islmi App",
              ),
              IntroScreen(
                imagePath: "assets/images/mosque.png",
                text1: "Welcome To Islami",
                text2: "We Are Very Excited To Have You In Our Community",
              ),
              IntroScreen(
                imagePath: "assets/images/quran.png",
                text1: "Reading the Quran",
                text2: "Read, and your Lord is the Most Generous",
              ),
              IntroScreen(
                imagePath: "assets/images/do3aa.png",
                text1: "Bearish",
                text2: "Praise the name of your Lord, the Most High",
              ),
              IntroScreen(
                imagePath: "assets/images/radio.png",
                text1: "Holy Quran Radio",
                text2:
                    "You can listen to the Holy Quran Radio through the application for free and easily",
              ),
            ],
          ),
          Container(
            margin: EdgeInsetsDirectional.only(start: 15, end: 15),
            alignment: Alignment(0, 0.96),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutCubic,
                    );
                  },
                  child: Text(
                    buttonText1,
                    style: TextStyle(color: Color(0xFFE2BE7F), fontSize: 15),
                  ),
                ),
                SmoothPageIndicator(controller: pageController, count: 5),
                GestureDetector(
                  onTap: () {
                    pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOutSine,
                    );
                    if (buttonText2 == "Finish") {
                      Navigator.of(context).pushNamed(HomeScreen.routeName);
                    }
                  },
                  child: Text(
                    buttonText2,
                    style: TextStyle(color: Color(0xFFE2BE7F), fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
