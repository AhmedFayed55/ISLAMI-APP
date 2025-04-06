import 'package:flutter/material.dart';
import 'package:islami_app_new/home/tabs/hadith_tab/hadith_tab.dart';
import 'package:islami_app_new/home/tabs/quran_tabs/quran_tab.dart';
import 'package:islami_app_new/home/tabs/radio_tab/radio_tab.dart';
import 'package:islami_app_new/home/tabs/sebha_tab/sebha_tab.dart';
import 'package:islami_app_new/home/tabs/timer_tab/timer_tab1.dart';
import 'package:islami_app_new/utils/app_images.dart';

import '../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> backgroundImages = [
    AppImages.quranBG,
    AppImages.hadithBG,
    AppImages.sebhaBG,
    AppImages.radioBG,
    AppImages.timerBG,
  ];
  List<Widget> tabs = [
    QuranTab(),
    HadithTab(),
    SebhaTab(),
    RadioTab(),
    TimerTabTwo()
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          backgroundImages[selectedIndex],
          fit: BoxFit.fill,
          height: double.infinity,
          width: double.infinity,
        ),
        Scaffold(
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(canvasColor: AppColor.gold),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              showSelectedLabels: true,
              selectedItemColor: AppColor.white,
              unselectedItemColor: AppColor.black,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              // backgroundColor: AppColor.gold,
              // type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: buildItemInBottomNavBar(
                    index: 0,
                    imageName: "icon_quran",
                  ),
                  label: "quran",
                ),
                BottomNavigationBarItem(
                  icon: buildItemInBottomNavBar(
                    index: 1,
                    imageName: "icon_hadith",
                  ),
                  label: "hadith",
                ),
                BottomNavigationBarItem(
                  icon: buildItemInBottomNavBar(
                    index: 2,
                    imageName: "icon_sebha",
                  ),
                  label: "sebha",
                ),
                BottomNavigationBarItem(
                  icon: buildItemInBottomNavBar(
                    index: 3,
                    imageName: "icon_radio",
                  ),
                  label: "radio",
                ),
                BottomNavigationBarItem(
                  icon: buildItemInBottomNavBar(
                    index: 4,
                    imageName: "icon_timer",
                  ),
                  label: "timer",
                ),
              ],
            ),
          ),
          body: tabs[selectedIndex],
        ),
      ],
    );
  }

  Widget buildItemInBottomNavBar({
    required int index,
    required String imageName,
  }) {
    return selectedIndex == index
        ? Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 6, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(66),
            color: Color(0x99202020),
          ),
          child: ImageIcon(AssetImage("assets/images/$imageName.png")),
        )
        : ImageIcon(AssetImage("assets/images/$imageName.png"));
  }
}
