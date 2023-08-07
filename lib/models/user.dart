// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/badges.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/diet.dart';
import 'package:gympact/models/past_workout.dart';
import 'package:gympact/models/progress.dart';
import 'package:gympact/models/workout.dart';

class User {
  int? id;
  final int? coin;
  final int? level;
  String? gymId;
  final double? weight;
  final double? heigth;
  final String name;
  String? gender;
  final String phone;
  String? email;
  String? password;
  String? goal;
  String? profileImg;
  int? highestStreak;
  int? currentStreak;
  int? highestStreakThisMonth;
  int? waterReminder;
  int? stretchReminder;
  final List<Badges>? badgesList;
  final List<Workout>? workoutList;
  final List<PastWorkout>? pastWorkoutList;
  final List<Progress>? progressList;
  final Diet? diet;
  final Progress? progress;
  final CurrentPackage? currentPackage;
  final DateTime? dob;
  final DateTime? joinOn;
  final DateTime? lastVisit;
  final Role role;

  User({
    this.id,
    required this.coin,
    required this.level,
    this.gymId,
    required this.weight,
    required this.heigth,
    required this.name,
    this.gender,
    required this.phone,
    this.email,
    this.password,
    this.goal,
    this.profileImg,
    this.highestStreak,
    this.currentStreak,
    this.highestStreakThisMonth,
    this.waterReminder,
    this.stretchReminder,
    required this.badgesList,
    required this.workoutList,
    required this.pastWorkoutList,
    required this.progressList,
    this.diet,
    this.progress,
    required this.currentPackage,
    required this.dob,
    required this.joinOn,
    required this.lastVisit,
    required this.role,
  });

  User copyWith({
    int? id,
    int? coin,
    int? level,
    String? gymId,
    double? weight,
    double? heigth,
    String? name,
    String? gender,
    String? phone,
    String? email,
    String? password,
    String? goal,
    String? profileImg,
    int? highestStreak,
    int? currentStreak,
    int? highestStreakThisMonth,
    int? waterReminder,
    int? stretchReminder,
    List<Badges>? badgesList,
    List<Workout>? workoutList,
    List<PastWorkout>? pastWorkoutList,
    List<Progress>? progressList,
    Diet? diet,
    Progress? progress,
    CurrentPackage? currentPackage,
    DateTime? dob,
    DateTime? joinOn,
    DateTime? lastVisit,
    Role? role,
  }) {
    return User(
      id: id ?? this.id,
      coin: coin ?? this.coin,
      level: level ?? this.level,
      gymId: gymId ?? this.gymId,
      weight: weight ?? this.weight,
      heigth: heigth ?? this.heigth,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      goal: goal ?? this.goal,
      profileImg: profileImg ?? this.profileImg,
      highestStreak: highestStreak ?? this.highestStreak,
      currentStreak: currentStreak ?? this.currentStreak,
      highestStreakThisMonth:
          highestStreakThisMonth ?? this.highestStreakThisMonth,
      waterReminder: waterReminder ?? this.waterReminder,
      stretchReminder: stretchReminder ?? this.stretchReminder,
      badgesList: badgesList ?? this.badgesList,
      workoutList: workoutList ?? this.workoutList,
      pastWorkoutList: pastWorkoutList ?? this.pastWorkoutList,
      progressList: progressList ?? this.progressList,
      diet: diet ?? this.diet,
      progress: progress ?? this.progress,
      currentPackage: currentPackage ?? this.currentPackage,
      dob: dob ?? this.dob,
      joinOn: joinOn ?? this.joinOn,
      lastVisit: lastVisit ?? this.lastVisit,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'coin': coin,
      'level': level,
      'gymId': gymId,
      'weight': weight,
      'heigth': heigth,
      'name': name,
      'gender': gender,
      'phone': phone,
      'email': email,
      'password': password,
      'goal': goal,
      'profileImg': profileImg,
      'highestStreak': highestStreak,
      'currentStreak': currentStreak,
      'highestStreakThisMonth': highestStreakThisMonth,
      'waterReminder': waterReminder,
      'stretchReminder': stretchReminder,
      'badgesList': badgesList?.map((x) => x.toMap()).toList(),
      'workoutList': workoutList?.map((x) => x.toMap()).toList(),
      'pastWorkoutList': pastWorkoutList?.map((x) => x.toMap()).toList(),
      'progressList': progressList?.map((x) => x.toMap()).toList(),
      'diet': diet?.toMap(),
      'progress': progress?.toMap(),
      'currentPackage': currentPackage?.toMap(),
      'dob': dob != null
          ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dob!).toString()
          : null,
      'joinOn': joinOn != null
          ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(joinOn!).toString()
          : null,
      'lastVisit': lastVisit != null
          ? DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
              .format(lastVisit!)
              .toString()
          : null,
      'role': role.name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] != null ? map['id'] as int : null,
      coin: map['coin'] != null ? map['coin'] as int : null,
      level: map['level'] != null ? map['level'] as int : null,
      gymId: map['gymId'] != null ? map['gymId'] as String : null,
      weight: map['weight'] != null ? map['weight'] as double : null,
      heigth: map['heigth'] != null ? map['heigth'] as double : null,
      name: map['name'] as String,
      gender: map['gender'] != null ? map['gender'] as String : null,
      phone: map['phone'] as String,
      email: map['email'] != null ? map['email'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      goal: map['goal'] != null ? map['goal'] as String : null,
      profileImg:
          map['profileImg'] != null ? map['profileImg'] as String : null,
      highestStreak:
          map['highestStreak'] != null ? map['highestStreak'] as int : null,
      currentStreak:
          map['currentStreak'] != null ? map['currentStreak'] as int : null,
      highestStreakThisMonth: map['highestStreakThisMonth'] != null
          ? map['highestStreakThisMonth'] as int
          : null,
      waterReminder:
          map['waterReminder'] != null ? map['waterReminder'] as int : null,
      stretchReminder:
          map['stretchReminder'] != null ? map['stretchReminder'] as int : null,
      badgesList: map['badgesList'] != null
          ? List<Badges>.from(
              (map['badgesList'] as List<dynamic>).map<Badges?>(
                (x) => Badges.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      workoutList: map['workoutList'] != null
          ? List<Workout>.from(
              (map['workoutList'] as List<dynamic>).map<Workout?>(
                (x) => Workout.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      pastWorkoutList: map['pastWorkoutList'] != null
          ? List<PastWorkout>.from(
              (map['pastWorkoutList'] as List<dynamic>).map<PastWorkout?>(
                (x) => PastWorkout.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      progressList: map['progressList'] != null
          ? List<Progress>.from(
              (map['progressList'] as List<dynamic>).map<Progress?>(
                (x) => Progress.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      diet: map['diet'] != null
          ? Diet.fromMap(map['diet'] as Map<String, dynamic>)
          : null,
      progress: map['progress'] != null
          ? Progress.fromMap(map['progress'] as Map<String, dynamic>)
          : null,
      currentPackage: map['currentPackage'] != null
          ? CurrentPackage.fromMap(
              map['currentPackage'] as Map<String, dynamic>)
          : null,
      dob: map['dob'] != null
          ? DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['dob'])
          : null,
      joinOn: map['joinOn'] != null
          ? DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['joinOn'])
          : null,
      lastVisit: map['lastVisit'] != null
          ? DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['lastVisit'])
          : null,
      role:
          Role.values.firstWhere((e) => e.toString() == 'Role.${map['role']}'),
    );
  }
//DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse("sdsds")
  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, coin: $coin, level: $level, gymId: $gymId, weight: $weight, heigth: $heigth, name: $name, gender: $gender, phone: $phone, email: $email, password: $password, goal: $goal, profileImg: $profileImg, highestStreak: $highestStreak, currentStreak: $currentStreak, highestStreakThisMonth: $highestStreakThisMonth, waterReminder: $waterReminder, stretchReminder: $stretchReminder, badgesList: $badgesList, workoutList: $workoutList, pastWorkoutList: $pastWorkoutList, progressList: $progressList, diet: $diet, progress: $progress, currentPackage: $currentPackage, dob: $dob, joinOn: $joinOn, lastVisit: $lastVisit, role: $role)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.coin == coin &&
        other.level == level &&
        other.gymId == gymId &&
        other.weight == weight &&
        other.heigth == heigth &&
        other.name == name &&
        other.gender == gender &&
        other.phone == phone &&
        other.email == email &&
        other.password == password &&
        other.goal == goal &&
        other.profileImg == profileImg &&
        other.highestStreak == highestStreak &&
        other.currentStreak == currentStreak &&
        other.highestStreakThisMonth == highestStreakThisMonth &&
        other.waterReminder == waterReminder &&
        other.stretchReminder == stretchReminder &&
        listEquals(other.badgesList, badgesList) &&
        listEquals(other.workoutList, workoutList) &&
        listEquals(other.pastWorkoutList, pastWorkoutList) &&
        listEquals(other.progressList, progressList) &&
        other.diet == diet &&
        other.progress == progress &&
        other.currentPackage == currentPackage &&
        other.dob == dob &&
        other.joinOn == joinOn &&
        other.lastVisit == lastVisit &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        coin.hashCode ^
        level.hashCode ^
        gymId.hashCode ^
        weight.hashCode ^
        heigth.hashCode ^
        name.hashCode ^
        gender.hashCode ^
        phone.hashCode ^
        email.hashCode ^
        password.hashCode ^
        goal.hashCode ^
        profileImg.hashCode ^
        highestStreak.hashCode ^
        currentStreak.hashCode ^
        highestStreakThisMonth.hashCode ^
        waterReminder.hashCode ^
        stretchReminder.hashCode ^
        badgesList.hashCode ^
        workoutList.hashCode ^
        pastWorkoutList.hashCode ^
        progressList.hashCode ^
        diet.hashCode ^
        progress.hashCode ^
        currentPackage.hashCode ^
        dob.hashCode ^
        joinOn.hashCode ^
        lastVisit.hashCode ^
        role.hashCode;
  }
}
