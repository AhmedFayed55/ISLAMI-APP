import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  String imagePath;
  String text1;
  String text2;

  IntroScreen({
    required this.imagePath,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF212121),
      child: Column(
        /*mainAxisAlignment: MainAxisAlignment.center,*/
        children: [
          Image.asset("assets/images/bar.png"),
          SizedBox(height: 70),
          Image.asset(imagePath),
          SizedBox(height: 50),
          Text(
            text1,
            style: TextStyle(
              color: Color(0xFFE2BE7F),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 50),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsetsDirectional.only(start: 20, end: 20),
            child: Text(
              text2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE2BE7F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
