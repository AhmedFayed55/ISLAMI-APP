import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:islami_app_new/api/api_manager.dart';
import 'package:islami_app_new/models/prayer_response_model.dart';
import 'package:islami_app_new/utils/app_images.dart';
import 'package:islami_app_new/utils/date_time_formatter.dart';

import '../../../utils/app_colors.dart';
import 'azkar_tab.dart';

class TimerTabTwo extends StatefulWidget {
  const TimerTabTwo({super.key});

  @override
  State<TimerTabTwo> createState() => _TimerTabTwoState();
}

class _TimerTabTwoState extends State<TimerTabTwo> {
  Map<String, String> azkarName = {
    "أذكار الصباح": "Morning Azkar",
    "أذكار المساء": "Evening Azkar",
    "أذكار بعد السلام من الصلاة المفروضة": "Post-Prayer Azkar",
    "تسابيح": "Praise Chants",
    "أذكار النوم": "Sleep Azkar",
    "أذكار الاستيقاظ": "Wake Azkar",
  };
  String nextPrayerName = "";
  Map<String, dynamic>? prayerTimes;
  Timer? timer;
  late ValueNotifier<String> remainingTimeNotifier;

  @override
  void initState() {
    super.initState();
    remainingTimeNotifier = ValueNotifier<String>("00:00:00");
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    remainingTimeNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .02),
        child: Column(
          children: [
            Image.asset(AppImages.bar),
            SizedBox(
              width: double.infinity,
              height: size.height * .40,
              child: FutureBuilder<PrayerResponseModel>(
                future: ApiManager.getPrayersTime(),
                builder: (
                  context,
                  AsyncSnapshot<PrayerResponseModel> snapshot,
                ) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: AppColor.gold),
                    );
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        const Text(
                          'SomeThing went wrong',
                          style: TextStyle(color: AppColor.gold),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            ApiManager.getPrayersTime();
                            setState(() {});
                          },
                          child: const Text('Try Again'),
                        ),
                      ],
                    );
                  }
                  PrayerResponseModel data = snapshot.data!;
                  prayerTimes = data.data!.timings!.toJson();
                  remainingTimeNotifier.value = getNextPrayerAndRemainingTime(
                    prayerTimes!,
                  );
                  nextPrayerName = getNextPrayerAndRemainingTime(
                    prayerTimes!,
                    returnPrayerName: true,
                  );
                  List<String> prayerNames = [
                    'Fajr',
                    'Dhuhr',
                    'Asr',
                    'Maghrib',
                    'Isha',
                  ];
                  int initialPage = prayerNames.indexOf(nextPrayerName);
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: AppColor.brown,
                      image: const DecorationImage(
                        image: AssetImage(AppImages.timerFrame),
                        fit: BoxFit.fill,
                      ),
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
                              AutoSizeText(
                                DateFormatter.formatGregorian(
                                  data.data!.date!.gregorian!,
                                ),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                              ),
                              Column(
                                children: [
                                  AutoSizeText(
                                    "Pray Time",
                                    style: TextStyle(
                                      color: Color(0xB3202020),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  AutoSizeText(
                                    data.data!.date!.gregorian!.weekday!.en!,
                                    style: TextStyle(
                                      color: Color(0xE6202020),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              AutoSizeText(
                                DateFormatter.formatHijri(
                                  data.data!.date!.hijri!,
                                ),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CarouselSlider.builder(
                          itemCount: prayerTimes!.length,
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
                                    Color(0xffB19768),
                                  ],
                                ),
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.height * .03,
                                      bottom: size.height * .01,
                                    ),
                                    child: text(
                                      prayerTimes!.keys.elementAt(index),
                                      16,
                                    ),
                                  ),
                                  text(
                                    TimeConverter.to12Hour(
                                      prayerTimes!.values.elementAt(index),
                                    ),
                                    30,
                                  ),
                                ],
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: size.height * .2,
                            enlargeCenterPage: true,
                            viewportFraction: .24,
                            enlargeFactor: .15,
                            initialPage:
                                initialPage >= 0
                                    ? initialPage
                                    : 0, // تحديد الصلاة القادمة كـ initialPage
                          ),
                        ),
                        Positioned(
                          bottom: size.height * .03,
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColor.brown,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ValueListenableBuilder<String>(
                                  valueListenable: remainingTimeNotifier,
                                  builder: (context, value, child) {
                                    return Text(
                                      "Next Pray - $value",
                                      style: TextStyle(
                                        color: AppColor.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * .022),
            text("Azkar", 16),
            SizedBox(height: size.height * .022),
            SizedBox(
              height: size.height * .25,
              child: Row(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return azkarItem(
                          size.width * .4,
                          azkarName.keys.elementAt(index),
                          size.height * .014,
                          azkarName.values.elementAt(index),
                        );
                      },
                      itemCount: azkarName.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget text(String text, double size) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: AppColor.white,
        fontSize: size,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted && prayerTimes != null) {
        remainingTimeNotifier.value = getNextPrayerAndRemainingTime(
          prayerTimes!,
        );
        String newNextPrayerName = getNextPrayerAndRemainingTime(
          prayerTimes!,
          returnPrayerName: true,
        );
        if (newNextPrayerName != nextPrayerName) {
          setState(() {
            nextPrayerName = newNextPrayerName;
          });
        }
      }
    });
  }

  String getNextPrayerAndRemainingTime(
    Map<String, dynamic> prayerTimes, {
    bool returnPrayerName = false,
  }) {
    DateTime now = DateTime.now();
    List<String> prayerNames = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];
    List<DateTime> prayerDateTimes = [];
    for (String prayer in prayerNames) {
      String time = prayerTimes[prayer];
      DateTime prayerTime = DateFormat("HH:mm").parse(time);
      prayerTime = DateTime(
        now.year,
        now.month,
        now.day,
        prayerTime.hour,
        prayerTime.minute,
      );
      if (prayerTime.isBefore(now)) {
        prayerTime = prayerTime.add(Duration(days: 1));
      }
      prayerDateTimes.add(prayerTime);
    }

    DateTime nextPrayerTime = prayerDateTimes.reduce(
      (a, b) => a.isBefore(b) ? a : b,
    );
    int nextPrayerIndex = prayerDateTimes.indexOf(nextPrayerTime);
    String nextPrayer = prayerNames[nextPrayerIndex];

    Duration remaining = nextPrayerTime.difference(now);
    int hours = remaining.inHours;
    int minutes = remaining.inMinutes % 60;
    int seconds = remaining.inSeconds % 60;

    String formattedTime =
        "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";

    if (returnPrayerName) {
      return nextPrayer;
    }

    return formattedTime;
  }

  Widget azkarItem(
    double width,
    var argument,
    double position,
    String azkarType,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(
          context,
        ).pushNamed(AzkarTab.routeName, arguments: argument);
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
              child: AutoSizeText(
                azkarType,
                style: TextStyle(color: AppColor.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
