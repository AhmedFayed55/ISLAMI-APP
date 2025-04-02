import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:islami_app_new/home/tabs/quran_tabs/sura_content_item.dart';

import '../../../models/sura_model.dart';
import '../../app_colors.dart';

class SuraDetailsScreen extends StatefulWidget {
  static const String routeName = "sura_details_screen";

  @override
  State<SuraDetailsScreen> createState() => _SuraDetailsScreenState();
}

class _SuraDetailsScreenState extends State<SuraDetailsScreen> {
  List<String> verses = [];
  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as SuraModel;
    if (verses.isEmpty) {
      loadSuraFile(args.fileName);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        title: Text(args.suraEnName, style: TextStyle(color: AppColor.gold)),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColor.gold),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: AppColor.black,
            child: Image.asset(
              "assets/images/decoration_nv.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20),
              Text(
                args.suraArName,
                style: TextStyle(color: AppColor.gold, fontSize: 24),
              ),
              SizedBox(height: 45),
              Expanded(
                child:
                    verses.isEmpty
                        ? Center(
                          child: CircularProgressIndicator(
                            color: AppColor.gold,
                          ),
                        )
                        : ListView.builder(
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                              child: SuraContentItem(
                                content: verses[index],
                                index: index,
                                isSelected: selectedIndex == index,
                              ),
                            );
                          },
                          itemCount: verses.length,
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void loadSuraFile(String fileName) async {
    try {
      String suraContent = await rootBundle.loadString(
        "assets/files/suras/$fileName",
      );
      List<String> suraLines = suraContent.split("\n");
      setState(() {
        verses = suraLines;
      });
    } catch (e) {
      print("Error loading sura file: $e");
    }
  }
}
