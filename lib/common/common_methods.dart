import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:gympact/models/attendance.dart';
import 'package:gympact/models/progress.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:time_machine/time_machine.dart';

class Common {
  static String formatDate(DateTime dt) {
    return "${dt.day.toString()}/${dt.month.toString()}/${dt.year.toString()}";
  }

  static int getAge(DateTime dob) {
    LocalDate today = LocalDate.today();
    LocalDate dobLocal = LocalDate.dateTime(dob);

    return today.periodSince(dobLocal).years;
  }

  static Future<bool> checkUserAttendance() async {
    var pref = await SharedPreferences.getInstance();
    if (pref.get("lastAttendance") == null) {
      //fetch if and store in pref.
      return false;
    }

    Attendance userLastAttendance =
        Attendance.fromMap(jsonDecode(pref.get("lastAttendance").toString()));
    DateTime today = DateTime.now();
    if (userLastAttendance.dateTime.day == today.day &&
        userLastAttendance.dateTime.month == today.month &&
        userLastAttendance.dateTime.year == today.year) {
      return true;
    }

    return false;
  }

  static List<FlSpot> flSpots(List<Progress> progressList, String type) {
    return progressList
        .map((e) => FlSpot(e.dateTime.day.toDouble(), e.weight ?? 0))
        .toList();
  }
}
