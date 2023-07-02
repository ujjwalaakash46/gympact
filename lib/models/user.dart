// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gympact/constants/enums.dart';
import 'package:gympact/models/badges.dart';
import 'package:gympact/models/current_package.dart';
import 'package:gympact/models/diet.dart';
import 'package:gympact/models/past_workout.dart';
import 'package:gympact/models/progress.dart';
import 'package:gympact/models/workout.dart';

class User {
  final int id;
  final int coin;
  final int level;
  final int gymId;
  final double weight;
  final double heigth;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String goal;
  final List<Badges> badgesList;
  final List<Workout> workoutList;
  final List<PastWorkout> pastWorkoutList;
  final Diet? diet;
  final Progress? progress;
  final CurrentPackage currentPackage;
  final DateTime dob;
  final DateTime joinOn;
  final DateTime lastVisit;
  final Role role;

  User({
    required this.id,
    required this.coin,
    required this.level,
    required this.gymId,
    required this.weight,
    required this.heigth,
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
    required this.goal,
    required this.badgesList,
    required this.workoutList,
    required this.pastWorkoutList,
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
    int? gymId,
    double? weight,
    double? heigth,
    String? name,
    String? phone,
    String? email,
    String? password,
    String? goal,
    List<Badges>? badgesList,
    List<Workout>? workoutList,
    List<PastWorkout>? pastWorkoutList,
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
      phone: phone ?? this.phone,
      email: email ?? this.email,
      password: password ?? this.password,
      goal: goal ?? this.goal,
      badgesList: badgesList ?? this.badgesList,
      workoutList: workoutList ?? this.workoutList,
      pastWorkoutList: pastWorkoutList ?? this.pastWorkoutList,
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
      'phone': phone,
      'email': email,
      'password': password,
      'goal': goal,
      'badgesList': badgesList.map((x) => x.toMap()).toList(),
      'workoutList': workoutList.map((x) => x.toMap()).toList(),
      'pastWorkoutList': pastWorkoutList.map((x) => x.toMap()).toList(),
      'diet': diet?.toMap(),
      'progress': progress?.toMap(),
      'currentPackage': currentPackage.toMap(),
      'dob': dob.millisecondsSinceEpoch,
      'joinOn': joinOn.millisecondsSinceEpoch,
      'lastVisit': lastVisit.millisecondsSinceEpoch,
      'role': role,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as int,
      coin: map['coin'] as int,
      level: map['level'] as int,
      gymId: map['gymId'] as int,
      weight: map['weight'] as double,
      heigth: map['heigth'] as double,
      name: map['name'] as String,
      phone: map['phone'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      goal: map['goal'] as String,
      badgesList: List<Badges>.from(
        (map['badgesList'] as List<int>).map<Badges>(
          (x) => Badges.fromMap(x as Map<String, dynamic>),
        ),
      ),
      workoutList: List<Workout>.from(
        (map['workoutList'] as List<int>).map<Workout>(
          (x) => Workout.fromMap(x as Map<String, dynamic>),
        ),
      ),
      pastWorkoutList: List<PastWorkout>.from(
        (map['pastWorkoutList'] as List<int>).map<PastWorkout>(
          (x) => PastWorkout.fromMap(x as Map<String, dynamic>),
        ),
      ),
      diet: map['diet'] != null
          ? Diet.fromMap(map['diet'] as Map<String, dynamic>)
          : null,
      progress: map['progress'] != null
          ? Progress.fromMap(map['progress'] as Map<String, dynamic>)
          : null,
      currentPackage:
          CurrentPackage.fromMap(map['currentPackage'] as Map<String, dynamic>),
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob'] as int),
      joinOn: DateTime.fromMillisecondsSinceEpoch(map['joinOn'] as int),
      lastVisit: DateTime.fromMillisecondsSinceEpoch(map['lastVisit'] as int),
      role: (map['role'] as Role),
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, coin: $coin, level: $level, gymId: $gymId, weight: $weight, heigth: $heigth, name: $name, phone: $phone, email: $email, password: $password, goal: $goal, badgesList: $badgesList, workoutList: $workoutList, pastWorkoutList: $pastWorkoutList, diet: $diet, progress: $progress, currentPackage: $currentPackage, dob: $dob, joinOn: $joinOn, lastVisit: $lastVisit, role: $role)';
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
        other.phone == phone &&
        other.email == email &&
        other.password == password &&
        other.goal == goal &&
        listEquals(other.badgesList, badgesList) &&
        listEquals(other.workoutList, workoutList) &&
        listEquals(other.pastWorkoutList, pastWorkoutList) &&
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
        phone.hashCode ^
        email.hashCode ^
        password.hashCode ^
        goal.hashCode ^
        badgesList.hashCode ^
        workoutList.hashCode ^
        pastWorkoutList.hashCode ^
        diet.hashCode ^
        progress.hashCode ^
        currentPackage.hashCode ^
        dob.hashCode ^
        joinOn.hashCode ^
        lastVisit.hashCode ^
        role.hashCode;
  }
}
