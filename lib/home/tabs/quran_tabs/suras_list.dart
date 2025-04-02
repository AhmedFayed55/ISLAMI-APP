import 'package:flutter/material.dart';

import '../../../models/sura_model.dart';
import '../../app_colors.dart';

class SurasList extends StatelessWidget {
  SuraModel suraModel;
  int index;

  SurasList({required this.suraModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset("assets/images/shape.png"),
            Text("${index + 1}", style: TextStyle(color: AppColor.white)),
          ],
        ),
        SizedBox(width: 24),
        Column(
          children: [
            text(suraModel.suraEnName, 20),
            SizedBox(height: 7),
            text("${suraModel.ayasNum} Verses", 16),
          ],
        ),
        Spacer(),
        text(suraModel.suraArName, 20),
      ],
    );
  }

  Widget text(String text, double font) {
    return Text(text, style: TextStyle(fontSize: font, color: AppColor.white));
  }
}
