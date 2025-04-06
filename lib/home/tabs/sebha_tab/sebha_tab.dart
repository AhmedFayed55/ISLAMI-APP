import 'dart:math';

import 'package:flutter/material.dart';
import 'package:islami_app_new/utils/app_images.dart';

import '../../../utils/app_colors.dart';

class SebhaTab extends StatefulWidget {
  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  double angle = 0;
  int index = 0;
  List<String> azkar = ['سبحان الله', 'الحمد لله', 'الله اكبر'];
  List<String> azkar2 = [
    'وَسَبِّحُوهُ بُكْرَةً وَأَصِيلًا ',
    'وَإِن تَعُدُّواْ نِعْمَةَ اللّهِ لاَ تُحْصُوهاِ',
    'ولِتُكَبِّرُوا اللَّهَ عَلَى مَا هَدَاكُمْ'
  ];

  bool isMainStyle = true;
  int litCount = 0;
  final int totalBeads = 33;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery
        .of(context)
        .size
        .height;
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(AppImages.bar),
          Text(azkar2[index],
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColor.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,),
          ),
          SizedBox(height: height * .04,),
          isMainStyle ? Stack(
            alignment: Alignment.topCenter,
            children: [
              Image.asset(AppImages.sebhaHead),
              Padding(
                padding: EdgeInsets.only(top: height * .08),
                child: Transform.rotate(
                    angle: angle,
                    child: Image.asset(AppImages.sebhaBody)),
              ),
              Positioned(
                top: height * .18,
                child: Column(
                  children: [
                    Text(counter.toString(), style: TextStyle(
                      color: AppColor.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),),
                    SizedBox(height: height * .04,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent
                      ),
                      onPressed: onTap,
                      child: Text(azkar[index], style:
                      TextStyle(fontSize: 50, color: AppColor.white),),),
                    SizedBox(height: height * .02,),
                  ],
                ),
              ),
            ],
          )
              : sebhaStyleTwo(width, height),
          Container(
              margin: EdgeInsets.symmetric(
                  vertical: height * .015,
                  horizontal: width * .15),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.brown
                  ),
                  onPressed: changeStyle,
                  child: Text("Change Style", style: TextStyle(
                      fontSize: 25,
                      color: AppColor.white
                  ),))),
        ],
      ),
    );
  }

  Widget sebhaStyleTwo(double height, double width) {
    return Center(
      child: SizedBox(
        width: width * 1,
        height: height * 1,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              children: List.generate(totalBeads, (index) {
                double angle = (index / totalBeads) * 2 * pi;
                double radius = 180;
                return Positioned(
                  left: width * .24 + radius * cos(angle) - 15,
                  top: height * .5 + radius * sin(angle) - 15,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: index < litCount
                        ? AppColor.brown
                        : AppColor.white,
                  ),
                );
              }),
            ),
            Stack(
              children: [
                Positioned(
                  left: width * .115,
                  bottom: height * .3,
                  child: Column(
                    children: [
                      Text(counter.toString(), style: TextStyle(
                      color: AppColor.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: height * .04,),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent
                        ),
                        onPressed: onTap,
                        child: Text(azkar[index], style:
                        TextStyle(fontSize: 50, color: AppColor.white),),),
                      SizedBox(height: height * .02,),
                    ],
                  ),
                ),
              ],
            )
        ],
      ),
      ),
    );
  }

  void onTap() {
    counter++;
    angle += 0.1;
    if (counter % 33 == 0) {
      index++;
    }
    if (index == azkar.length) {
      index = 0;
      counter = 0;
    }
    if (!isMainStyle) {
      _lightNextBead();
    }
    setState(() {});
  }

  void _lightNextBead() {
    if (litCount < totalBeads - 1) {
      litCount++;
    } else {
      litCount = 0;
    }
    setState(() {});
  }

  void changeStyle() {
    isMainStyle = !isMainStyle;
    index = 0;
    counter = 0;
    litCount = 0;
    setState(() {});
  }
}
