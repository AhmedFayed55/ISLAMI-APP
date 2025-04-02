import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';

class TimerTab extends StatefulWidget {
  @override
  State<TimerTab> createState() => _TimerTabState();
}

class _TimerTabState extends State<TimerTab> {
  bool isMuted = false;
  List<String> prayers = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"];
  List<String> times = ["05:16", "06:50", "11:54", "02:40", "04:58", "06:23"];
  List<String> am_pm = ["AM", "AM", "AM", "PM", "PM", "PM"];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 14, end: 14),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/bar.png"),
            Container(
              decoration: BoxDecoration(
                color: AppColor.brown,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Stack(
                children: [
                  Image.asset("assets/images/times_background.png"),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 18,
                          end: 18,
                          top: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            text("16 Jul,\n2024", 16),
                            Column(
                              children: [
                                Text(
                                  "Prayer Time",
                                  style: TextStyle(
                                    color: Color(0xB5202020),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Tuesday",
                                  style: TextStyle(
                                    color: Color(0xE6202020),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            text("09 Muh,\n1446", 16),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 150,
                          viewportFraction: 0.30,
                          enlargeCenterPage: true,
                          scrollDirection: Axis.horizontal,
                          enableInfiniteScroll: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.scale,
                          enlargeFactor: 0.2,
                        ),
                        itemCount: prayers.length,
                        itemBuilder:
                            (
                              BuildContext context,
                              int itemIndex,
                              int pageViewIndex,
                            ) => Container(
                              margin: EdgeInsets.only(left: 7),
                              alignment: Alignment.center,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [AppColor.black, AppColor.gold],
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  text(prayers[itemIndex], 14),
                                  text(times[itemIndex], 24),
                                  text(am_pm[itemIndex], 14),
                                ],
                              ),
                            ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          children: [
                            Spacer(),
                            Text(
                              "Next Pray ",
                              style: TextStyle(
                                color: Color(0xBF202020),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "- 02:40 ",
                              style: TextStyle(
                                color: Color(0xFF202020),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                isMuted ? Icons.volume_off : Icons.volume_up,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  isMuted = !isMuted;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            text("Azkar", 25),
            SizedBox(height: 15),
            Row(
              children: [
                Image.asset("assets/images/azkar1.png"),
                SizedBox(width: 10),
                Image.asset("assets/images/azkar2.png"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget text(String text, double font) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: font, color: Color(0xFFFFFFFF)),
    );
  }
}
