import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:islami_app_new/models/prayer_response_model.dart';
import 'package:islami_app_new/models/radio_response_model.dart';
import 'package:islami_app_new/models/reciters_response_model.dart';

class ApiManager {

  static Future<RadioResponseModel> getRadioData() async {
    try {
      Uri uri = Uri.parse(
        "https://mp3quran.net/api/v3/radios?language=eng",
      ); // todo : parsing from string to link/Uri
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return RadioResponseModel.fromJson(jsonResponse);
    } catch (e) {
      throw e;
    }
  }

  static Future<RecitersResponseModel> getRecitersData() async {
    try {
      Uri uri = Uri.parse("https://mp3quran.net/api/v3/reciters");
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return RecitersResponseModel.fromJson(jsonResponse);
    } catch (e) {
      throw e;
    }
  }

  static Future<PrayerResponseModel> getPrayersTime() async {
    try {
      // todo : date must be update day by day
      // todo : also i wanna format it to day-month-year so i will use intl package
      var date = DateFormat("dd-MM-yyyy").format(DateTime.now());
      Uri uri = Uri.parse(
          "https://api.aladhan.com/v1/timingsByCity/$date?city=cairo&country=egypt");
      var response = await http.get(uri);
      var jsonResponse = jsonDecode(response.body);
      return PrayerResponseModel.fromJson(jsonResponse);
    } catch (e) {
      throw e;
    }
  }
}
