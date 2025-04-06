import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:islami_app_new/models/azkar_model.dart';
import 'package:islami_app_new/utils/app_colors.dart';
import 'package:islami_app_new/utils/app_images.dart';

class AzkarTab extends StatefulWidget {
  static const String routeName = "azkar_tab";

  @override
  State<AzkarTab> createState() => _AzkarTabState();
}

class _AzkarTabState extends State<AzkarTab> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(35)),
        ),
        centerTitle: true,
        title: AutoSizeText(
          args,
          style: TextStyle(
            color: AppColor.gold,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColor.black,
        iconTheme: IconThemeData(color: AppColor.gold, size: 25),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: size.height * .013,
          horizontal: size.width * .02,
        ),
        child: Stack(
          children: [
            Image.asset(AppImages.quranBG),
            Column(
              children: [
                FutureBuilder(
                  future: AzkarModel.loadAzkarModel(args),
                  builder: (context, snapshot) {
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
                              AzkarModel.loadAzkarModel(args);
                              setState(() {});
                            },
                            child: const Text('Try Again'),
                          ),
                        ],
                      );
                    }
                    List<AzkarModel> data = snapshot.data!;
                    return Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .0155,
                              vertical: size.height * .02,
                            ),
                            margin: EdgeInsets.only(bottom: size.height * .02),
                            alignment: Alignment.center,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: AppColor.gold),
                              color: Colors.transparent,
                            ),
                            child: Column(
                              spacing: size.height * .01,
                              children: [
                                AutoSizeText(
                                  data[index].content!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColor.gold,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                AutoSizeText(
                                  data[index].description ?? "",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    color: AppColor.white,
                                    fontSize: 14,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: size.width * .2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColor.gold,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    data[index].count ?? 1.toString(),
                                    style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: data.length,
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
