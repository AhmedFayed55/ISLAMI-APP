import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app_new/utils/app_images.dart';

import '../../../models/hadith_model.dart';
import '../../../utils/app_colors.dart';
import 'hadith_details_screen.dart';

class HadithTab extends StatefulWidget {
  @override
  State<HadithTab> createState() => _HadithTabState();
}

class _HadithTabState extends State<HadithTab> {
  List<HadithModel> hadithList = [];

  @override
  Widget build(BuildContext context) {
    if (hadithList.isEmpty) {
      loadHadithFile();
    }
    return Container(
      child: Column(
        children: [
          Image.asset(AppImages.bar),
          hadithList.isEmpty
              ? CircularProgressIndicator(color: AppColor.gold)
              : CarouselSlider.builder(
                options: CarouselOptions(
                  height: 600,
                  viewportFraction: 0.75,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  enableInfiniteScroll: true,
                ),
                itemCount: hadithList.length,
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) =>
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              HadithDetailsScreen.routeName,
                              arguments: hadithList[itemIndex],
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 30,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: AppColor.gold,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                  AppImages.hadithItemBG,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  hadithList[itemIndex].title,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Expanded(
                                  child: Text(
                                    hadithList[itemIndex].content.join(),
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
              ),
        ],
      ),
    );
  }

  void loadHadithFile() async {
    for (int i = 1; i <= 50; i++) {
      String hadithContent = await rootBundle.loadString(
        "assets/files/ahadith/h${i}.txt",
      );
      List<String> hadithLines = hadithContent.split("\n");
      String title = hadithLines[0]; ////title
      hadithLines.removeAt(0);

      /// remove content
      HadithModel hadithModel = HadithModel(title: title, content: hadithLines);
      hadithList.add(hadithModel);
      setState(() {});
    }
  }
}
