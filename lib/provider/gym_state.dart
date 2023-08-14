// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/package_end_detials.dart';
import 'package:gympact/models/workout.dart';
import 'package:gympact/service/user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:gympact/models/gym.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/service/gym_service.dart';

final gymProvider = StateNotifierProvider<GymNotifier, Gym?>((
  ref,
) =>
    GymNotifier());

class GymNotifier extends StateNotifier<Gym?> {
  GymNotifier() : super(null);

  Future<Gym?> fetchGymDetail() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.get("userId") == null) return null;
    var userId = int.parse(pref.get("userId").toString());
    // print("user id  " + userId.toString());
    final response = await GymService().getGymDetails(userId);
    if (response.statusCode == 200) {
      Gym gym = Gym.fromJson(response.body);
      // print("gym fetched" + gym.name!);
      pref.setString("gym", jsonEncode(gym));
      state = gym;
      return gym;
    }
    return null;
  }

  Gym? get() => state;
}

final attendanceProvider =
    StateNotifierProvider<AttendanceNotifier, Map<String, int>?>(
        (ref) => AttendanceNotifier());

class AttendanceNotifier extends StateNotifier<Map<String, int>?> {
  AttendanceNotifier() : super(null);

  Map<String, int>? get() => state;

  Future<Map<String, int>?> fetchAttendance(int gymId) async {
    // print("state");
    // print(state);
    final response = await GymService().attendanceDetails(gymId);
    // print("first fetched atten" + response.body.toString());
    if (response.statusCode == 200) {
      var map = (jsonDecode(response.body) as Map<String, dynamic>);
      Map<String, int> attenMap = {};
      attenMap["todayMorning"] = map["todayMorning"] as int;
      attenMap["todayEvening"] = map["todayEvening"] as int;
      attenMap["yesterdayMorning"] = map["yesterdayMorning"] as int;
      attenMap["yesterdayEvening"] = map["yesterdayEvening"] as int;

      // print("atten fetched" + attenMap.toString());
      // pref.setString("gym", jsonEncode(gym));
      state = attenMap;
      return attenMap;
    }
    return null;
  }
}

final packageEndsProvider =
    StateNotifierProvider<PackageEndsNotifier, PackageEndDetials>(
        (ref) => PackageEndsNotifier());

class PackageEndsNotifier extends StateNotifier<PackageEndDetials> {
  PackageEndsNotifier()
      : super(PackageEndDetials(packageEnded: null, packageEndsIn: null));

  PackageEndDetials get() => state;

  Future<PackageEndDetials> fetchPackageEnded(int gymId) async {
    final responseOfEnded = await GymService().getPackageEnded(gymId);
    final responseOfEnds = await GymService().getPackageEndsInDays(gymId);
    PackageEndDetials package = PackageEndDetials();

    if (responseOfEnded.statusCode == 200) {
      List<User> userEnded = List<User>.from(
          (json.decode(responseOfEnded.body) as List<dynamic>)
              .map((e) => User.fromMap(e as Map<String, dynamic>)));
      package.packageEnded = userEnded;
    }
    if (responseOfEnds.statusCode == 200) {
      List<User> userEndsIn = List<User>.from(
          (json.decode(responseOfEnds.body) as List<dynamic>)
              .map((e) => User.fromMap(e as Map<String, dynamic>)));
      package.packageEndsIn = userEndsIn;
    }
    state = package;
    return state;
  }
}

final workoutsProvider = StateNotifierProvider<WorkoutsNotifier, List<Workout>>(
    (ref) => WorkoutsNotifier());

class WorkoutsNotifier extends StateNotifier<List<Workout>> {
  WorkoutsNotifier() : super([]);

  List<Workout> get() => state;

  // Future<PackageEndDetials> fetchPackageEnded(int gymId) async {
  // final responseOfEnded = await GymService().getPackageEnded(gymId);
  // final responseOfEnds = await GymService().getPackageEndsInDays(gymId);
  // PackageEndDetials package = PackageEndDetials();

  // if (responseOfEnded.statusCode == 200) {
  //   List<User> userEnded = List<User>.from(
  //       (json.decode(responseOfEnded.body) as List<dynamic>)
  //           .map((e) => User.fromMap(e as Map<String, dynamic>)));
  //   package.packageEnded = userEnded;
  // }
  // if (responseOfEnds.statusCode == 200) {
  //   List<User> userEndsIn = List<User>.from(
  //       (json.decode(responseOfEnds.body) as List<dynamic>)
  //           .map((e) => User.fromMap(e as Map<String, dynamic>)));
  //   package.packageEndsIn = userEndsIn;
  // }
  // state = package;
  // return state;
  // }
}

final packageProvider = StateNotifierProvider<PackageNotifier, List<Package>>(
    (ref) => PackageNotifier());

class PackageNotifier extends StateNotifier<List<Package>> {
  PackageNotifier() : super([]);

  List<Package> get() => state;
}

final birthdayProvider = StateNotifierProvider<BirthdayNotifier, List<User>>(
    (ref) => BirthdayNotifier());

class BirthdayNotifier extends StateNotifier<List<User>> {
  BirthdayNotifier() : super([]);

  Future<List<User>> fetchBirthdayList(int gymId) async {
    final response = await UserService().birthdayList(gymId);
    if (response.statusCode == 200) {
      List<User> userList = List<User>.from(
          (json.decode(response.body) as List<dynamic>)
              .map((e) => User.fromMap(e as Map<String, dynamic>)));
      state = userList;
    }
    return state;
  }

  List<User> get() => state;
}

final statisticProvider =
    StateNotifierProvider<StatisticNotifier, Map<String, dynamic>>(
        (ref) => StatisticNotifier());

class StatisticNotifier extends StateNotifier<Map<String, dynamic>> {
  StatisticNotifier() : super({});

  Future<Map<String, dynamic>> fetchStatistic(int gymId) async {
    final response = await GymService().statistic(gymId);
    if (response.statusCode == 200) {
      Map<String, dynamic> map =
          (json.decode(response.body) as Map<String, dynamic>);
      state = map;
    }
    return state;
  }

  Map<String, dynamic> get() => state;
}
