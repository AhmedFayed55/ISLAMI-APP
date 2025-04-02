import 'package:flutter/material.dart';

import '../../app_colors.dart';

class SuraContentItem extends StatelessWidget {
  final String content;
  final int index;
  final bool isSelected;

  SuraContentItem({
    required this.content,
    required this.index,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: isSelected ? AppColor.black : AppColor.gold),
        color: isSelected ? AppColor.gold : Colors.transparent,
      ),
      child: Text(
        '$content [${index + 1}]',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? AppColor.black : AppColor.gold,
          fontSize: 20,
        ),
        textDirection: TextDirection.rtl,
      ),
    );
  }
}
