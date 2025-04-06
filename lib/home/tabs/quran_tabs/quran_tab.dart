import 'package:flutter/material.dart';
import 'package:islami_app_new/home/tabs/quran_tabs/sura_details.dart';
import 'package:islami_app_new/home/tabs/quran_tabs/suras_list.dart';
import 'package:islami_app_new/utils/app_images.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/sura_model.dart';
import '../../../utils/app_colors.dart';

class QuranTab extends StatefulWidget {
  @override
  State<QuranTab> createState() => _QuranTabState();
}

class _QuranTabState extends State<QuranTab> {
  int counter = 0;

  void addSuraList() {
    // تأكد أن القائمة فارغة قبل الإضافة
    if (SuraModel.suraList.isEmpty) {
      for (int i = 0; i < 114; i++) {
        SuraModel.suraList.add(
          SuraModel(
            suraArName: SuraModel.suraArList[i],
            suraEnName: SuraModel.suraEnList[i],
            ayasNum: SuraModel.ayasNumList[i],
            fileName: "${i + 1}.txt",
          ),
        );
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addSuraList();
    loadLastSura();
  }

  List<SuraModel> filterList = SuraModel.suraList; //114
  String searchText = '';
  Map<String, String> lastSura = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(AppImages.bar),
            TextField(
              style: TextStyle(color: AppColor.white),
              cursorColor: AppColor.white,
              decoration: InputDecoration(
                hintText: "  Sura Name",
                hintStyle: TextStyle(color: AppColor.white),
                prefixIcon: ImageIcon(
                  color: AppColor.gold,
                  AssetImage(AppImages.searchIcon),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColor.gold, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: AppColor.gold, width: 2),
                ),
              ),
              onChanged: (text) {
                searchText = text;
                filterList =
                    SuraModel.suraList.where((sura) {
                      return sura.suraArName.toLowerCase().contains(
                            searchText.toLowerCase(),
                          ) ||
                          sura.suraEnName.toLowerCase().contains(
                            searchText.toLowerCase(),
                          );
                    }).toList();

                setState(() {});
              },
            ),
            SizedBox(height: 20),
            searchText.isNotEmpty ? SizedBox() : buildMostRecently(),
            SizedBox(height: 10),
            Text(
              "Suras List",
              style: TextStyle(color: AppColor.white, fontSize: 16),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider(thickness: 2, indent: 45, endIndent: 35);
                  },
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //save data
                        saveLastSura(
                            suraEnName: filterList[index].suraArName,
                            suraArName: filterList[index].suraEnName,
                            numOfVerses: filterList[index].ayasNum);
                        Navigator.of(context).pushNamed(
                          SuraDetailsScreen.routeName,
                          arguments: filterList[index],
                        );
                      },
                      child: SurasList(
                        index: index,
                        suraModel: filterList[index],
                      ),
                    );
                  },
                  itemCount: filterList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget text(String text, double font) {
    return Text(
      text,
      style: TextStyle(
          fontSize: font, fontWeight: FontWeight.bold, color: AppColor.black),
    );
  }

  Widget buildMostRecently() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Most Recently",
          style: TextStyle(color: AppColor.white, fontSize: 16),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            if (lastSura['suraEnName'] != null &&
                lastSura['suraArName'] != null &&
                lastSura['numOfVerses'] != null) {
              Navigator.of(context).pushNamed(
                SuraDetailsScreen.routeName,
                arguments: SuraModel(
                  suraEnName: lastSura['suraEnName']!,
                  suraArName: lastSura['suraArName']!,
                  ayasNum:
                  (int.tryParse(lastSura['numOfVerses'] ?? '0') ?? 0)
                          .toString(),
                  fileName:
                  "${SuraModel.suraEnList.indexOf(lastSura['suraEnName']!) +
                      2}.txt",
                ),
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.gold,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    text(lastSura['suraArName'] ?? '', 22),
                    text(lastSura['suraEnName'] ?? '', 22),
                    text("${lastSura['numOfVerses']} verses", 14),
                  ],
                ),
                Image.asset(AppImages.mostRecentlyQuran),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> saveLastSura({
    required String suraEnName,
    required String suraArName,
    required String numOfVerses,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("suraEnName", suraEnName);
    await prefs.setString("suraArName", suraArName);
    await prefs.setString("numOfVerses", numOfVerses);
    await loadLastSura(); // update after reload
  }

  Future<Map<String, String>> getLastSura() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String suraEnName = prefs.getString("suraEnName") ?? '';
    String suraArName = prefs.getString("suraArName") ?? '';
    String numOfVerses = prefs.getString("numOfVerses") ?? '';
    return {
      "suraEnName": suraEnName,
      "suraArName": suraArName,
      "numOfVerses": numOfVerses,
    };
  }

  loadLastSura() async {
    lastSura = await getLastSura();
    setState(() {});
  }
}
