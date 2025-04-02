import 'package:flutter/material.dart';
import 'package:islami_app_new/home/tabs/quran_tabs/sura_details.dart';
import 'package:islami_app_new/home/tabs/quran_tabs/suras_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/sura_model.dart';
import '../../app_colors.dart';

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
  Map<String, String> loadSuraList = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        margin: EdgeInsets.all(13),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset("assets/images/bar.png"),
            TextField(
              style: TextStyle(color: AppColor.white),
              cursorColor: AppColor.white,
              decoration: InputDecoration(
                hintText: "  Sura Name",
                hintStyle: TextStyle(color: AppColor.white),
                prefixIcon: ImageIcon(
                  color: AppColor.gold,
                  AssetImage("assets/images/search_icon.png"),
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
      style: TextStyle(fontSize: font, fontWeight: FontWeight.bold),
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
          // أو يمكنك استخدام InkWell
          onTap: () {
            if (loadSuraList['suraEnName'] != null &&
                loadSuraList['suraArName'] != null &&
                loadSuraList['numOfVerses'] != null) {
              Navigator.of(context).pushNamed(
                SuraDetailsScreen.routeName,
                arguments: SuraModel(
                  suraEnName: loadSuraList['suraEnName']!,
                  suraArName: loadSuraList['suraArName']!,
                  ayasNum:
                      (int.tryParse(loadSuraList['numOfVerses'] ?? '0') ?? 0)
                          .toString(),
                  fileName:
                      "${SuraModel.suraEnList.indexOf(loadSuraList['suraEnName']!) + 2}.txt",
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
                    text(loadSuraList['suraArName'] ?? '', 24),
                    text(loadSuraList['suraEnName'] ?? '', 24),
                    text("${loadSuraList['numOfVerses']} verses", 14),
                  ],
                ),
                Image.asset("assets/images/quran3.png"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  saveLastSura({
    required String suraEnName,
    required String suraArName,
    required String numOfVerses,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("suraEnName", suraEnName);
    prefs.setString("suraArName", suraArName);
    prefs.setString("numOfVerses", numOfVerses);
    await loadLastSura();
  }

  getLastSura() async {
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
    loadSuraList = await getLastSura();
    setState(() {});
  }
}
