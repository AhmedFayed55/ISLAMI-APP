import 'package:flutter/material.dart';
import 'package:islami_app_new/utils/app_images.dart';

import '../../../models/hadith_model.dart';
import '../../../utils/app_colors.dart';

class HadithDetailsScreen extends StatelessWidget {
  static const String routeName = "hadith_details";

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)?.settings.arguments as HadithModel;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.black,
        iconTheme: IconThemeData(color: AppColor.gold),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: AppColor.black,
            child: Image.asset(
              AppImages.detailsScreenDecoration,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fill,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 20),
              Text(
                args.title,
                style: TextStyle(color: AppColor.gold, fontSize: 24),
              ),
              SizedBox(height: 45),
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22),
                      child: Text(
                        args.content[index],
                        textDirection: TextDirection.rtl,
                        style: TextStyle(color: AppColor.gold, fontSize: 18),
                      ),
                    );
                  },
                  itemCount: args.content.length,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
