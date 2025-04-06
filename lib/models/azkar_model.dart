import 'dart:convert';

import 'package:flutter/services.dart';

class AzkarModel {
  AzkarModel({
    this.category,
    this.count,
    this.description,
    this.reference,
    this.content,
  });

  AzkarModel.fromJson(dynamic json) {
    category = json['category'];
    count = json['count'];
    description = json['description'];
    reference = json['reference'];
    content = json['content'];
  }

  String? category;
  String? count;
  String? description;
  String? reference;
  String? content;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['category'] = category;
    map['count'] = count;
    map['description'] = description;
    map['reference'] = reference;
    map['content'] = content;
    return map;
  }

  static Future<List<AzkarModel>> loadAzkarModel(String azkarType) async {
    var jsonContent = await rootBundle.loadString(
      "assets/files/azkar/azkar.json",
    );
    Map<String, dynamic> jsonData = json.decode(jsonContent);
    if (jsonData[azkarType] is List) {
      List<AzkarModel> azkar =
          (jsonData[azkarType] as List)
              .map((e) => AzkarModel.fromJson(e))
              .toList();
      return azkar;
    } else {
      throw Exception("Azkar not found");
    }
  }
}
