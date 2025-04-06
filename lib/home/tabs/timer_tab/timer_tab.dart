import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:islami_app_new/api/api_manager.dart';
import 'package:islami_app_new/home/tabs/timer_tab/azkar_tab.dart';
import 'package:islami_app_new/models/prayer_response_model.dart';
import 'package:islami_app_new/utils/app_images.dart';
import 'package:islami_app_new/utils/date_time_formatter.dart';

import '../../../utils/app_colors.dart';

class TimerTab extends StatefulWidget {
  const TimerTab({super.key});

  @override
  State<TimerTab> createState() => _TimerTabState();
}

class _TimerTabState extends State<TimerTab> {
  Map<String, String> azkarName = {
    "أذكار الصباح": "Morning Azkar",
    "أذكار المساء": "Evening Azkar",
    "أذكار بعد السلام من الصلاة المفروضة": "Post-Prayer Azkar",
    "تسابيح": "Praise Chants",
    "أذكار النوم": "Sleep Azkar",
    "أذكار الاستيقاظ": "Wake Azkar",
  };
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * .03, vertical: size.height * .02),
        child: Column(
          children: [
            Image.asset(AppImages.bar),
            SizedBox(
              width: double.infinity,
              height: size.height * .38,
              child: FutureBuilder<PrayerResponseModel>(
                future: ApiManager.getPrayersTime(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor
                          .gold,),
                    );
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        const Text('SomeThing went wrong',
                          style: TextStyle(color: AppColor.gold),),
                        ElevatedButton(onPressed: () {
                          ApiManager.getPrayersTime();
                          setState(() {});
                        },
                            child: const Text('Try Again')),
                      ],
                    );
                  }
                  PrayerResponseModel data = snapshot.data!;
                  Map<String, dynamic> prayerTimes = data.data!.timings!
                      .toJson();
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: AppColor.brown,
                        image: const DecorationImage(image: AssetImage(AppImages
                            .timerFrame), fit: BoxFit.fill)
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                            top: size.height * .02,
                            right: size.width * .04,
                            left: size.width * .04,
                            bottom: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AutoSizeText(DateFormatter.formatGregorian(
                                    data.data!.date!.gregorian!),
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppColor.white
                                  ),),
                                Column(children: [
                                  AutoSizeText("Pray Time", style: TextStyle(
                                      color: Color(0xB3202020),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20
                                  ),),
                                  AutoSizeText(
                                    data.data!.date!.gregorian!.weekday!.en!,
                                    style: TextStyle(
                                        color: Color(0xE6202020),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20
                                    ),),
                                ],),
                                AutoSizeText(DateFormatter.formatHijri(
                                    data.data!.date!.hijri!), style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.white
                                ),)
                              ],
                            )),
                        CarouselSlider.builder(
                            itemCount: prayerTimes.length,
                            itemBuilder: (context, index, realIndex) {
                              return Container(
                                width: size.width * .22,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[
                                          Color(0xff202020),
                                          Color(0xffB19768)
                                        ])
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: size.height * .03,
                                          bottom: size.height * .01),
                                      child: text(
                                          prayerTimes.keys.elementAt(index),
                                          16),
                                    ),
                                    text(TimeConverter.to12Hour(
                                        prayerTimes.values.elementAt(index)),
                                        24),
                                  ],
                                ),
                              );
                            },
                            options: CarouselOptions(
                                height: size.height * .2,
                                enlargeCenterPage: true,
                                viewportFraction: .26,
                                enlargeFactor: .16
                            )),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * .022,),
            text("Azkar", 16),
            SizedBox(height: size.height * .022,),
            SizedBox(
              height: size.height * .25,
              child: Row(
                children: [
                  Expanded(
                      child: ListView.builder(itemBuilder: (context, index) {
                        return azkarItem(size.width * .4, azkarName.keys
                            .elementAt(index), size.height * .014, azkarName
                            .values.elementAt(index));
                      },
                        itemCount: azkarName.length,
                        scrollDirection: Axis.horizontal,
                      )
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget text(String text, double size) {
    return Text(text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColor.white,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),);
  }

  Widget azkarItem(double width, var argument, double position,
      String azkarType) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
            AzkarTab.routeName, arguments: argument);
      },
      child: Container(
        width: width,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(AppImages.azkar)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
                bottom: position,
                child: AutoSizeText(azkarType, style: TextStyle(
                  color: AppColor.white, fontSize: 18,
                ),))
          ],
        ),
      ),
    );
  }
}
