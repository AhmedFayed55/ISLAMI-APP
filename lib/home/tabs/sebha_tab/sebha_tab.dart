import 'package:flutter/material.dart';

import '../../app_colors.dart';

class SebhaTab extends StatefulWidget {
  @override
  State<SebhaTab> createState() => _SebhaTabState();
}

class _SebhaTabState extends State<SebhaTab> {
  int counter = 0;
  String text = "سبحان الله";
  double angle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Image.asset("assets/images/bar.png"),
          Text(
            "سَبِّحِ اسْمَ رَبِّكَ الأعلى",
            style: TextStyle(
              color: AppColor.white,
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
          ),
          Image.asset("assets/images/head.png"),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: angle,
                  child: Image.asset("assets/images/body.png"),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      counter++;
                      angle += 0.1;
                    });
                    if (counter > 32) {
                      text = "الحمد لله";
                    }
                    if (counter > 65) {
                      text = "الله اكبر";
                    }
                    if (counter == 100) {
                      counter = 0;
                      angle = 0.0;
                      text = "سبحان الله";
                    }
                  },
                  child: Text(
                    "\n\n\n$counter",
                    style: TextStyle(
                      color: AppColor.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
