import 'package:intl/intl.dart';
import 'package:islami_app_new/models/prayer_response_model.dart';

class DateFormatter {
  static String formatGregorian(Gregorian date) {
    return "${date.day} ${date.month!.en!.substring(0, 3)}, \n ${date.year}";
  }

  static String formatHijri(Hijri date) {
    return "${date.day} ${date.month!.en!.substring(0, 3)}, \n ${date.year}";
  }
}

class TimeConverter {
  static to12Hour(String time) {
    DateTime dateTime = DateFormat("HH:mm").parse(time);
    return DateFormat("hh:mm a").format(dateTime);
  }
}
