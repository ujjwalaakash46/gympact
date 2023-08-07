// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gympact/models/diet.dart';
import 'package:gympact/models/group.dart';
import 'package:gympact/models/package.dart';
import 'package:gympact/models/user.dart';
import 'package:gympact/models/workout.dart';

class Gym {
  int id;
  String name;
  String? gymCode;
  List<User>? admins;
  List<User>? trainers;
  List<Workout>? workouts;
  List<Diet>? diets;
  List<Package>? packages;
  List<Group>? groups;

  Gym({
    required this.id,
    required this.name,
    this.gymCode,
    required this.admins,
    required this.trainers,
    required this.workouts,
    required this.diets,
    required this.packages,
    required this.groups,
  });

  Gym copyWith({
    int? id,
    String? name,
    String? gymCode,
    List<User>? admins,
    List<User>? trainers,
    List<Workout>? workouts,
    List<Diet>? diets,
    List<Package>? packages,
    List<Group>? groups,
  }) {
    return Gym(
      id: id ?? this.id,
      name: name ?? this.name,
      gymCode: gymCode ?? this.gymCode,
      admins: admins ?? this.admins,
      trainers: trainers ?? this.trainers,
      workouts: workouts ?? this.workouts,
      diets: diets ?? this.diets,
      packages: packages ?? this.packages,
      groups: groups ?? this.groups,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'gymCode': gymCode,
      'admins': admins?.map((x) => x.toMap()).toList(),
      'trainers': trainers?.map((x) => x.toMap()).toList(),
      'workouts': workouts?.map((x) => x.toMap()).toList(),
      'diets': diets?.map((x) => x.toMap()).toList(),
      'packages': packages?.map((x) => x.toMap()).toList(),
      'groups': groups?.map((x) => x.toMap()).toList(),
    };
  }

  factory Gym.fromMap(Map<String, dynamic> map) {
    return Gym(
      id: map['id'] as int,
      name: map['name'] as String,
      gymCode: map['gymCode'] != null ? map['gymCode'] as String : null,
      admins: map['admins'] != null
          ? List<User>.from(
              (map['admins'] as List<dynamic>).map<User?>(
                (x) => User.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      trainers: map['trainers'] != null
          ? List<User>.from(
              (map['trainers'] as List<dynamic>).map<User?>(
                (x) => User.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      workouts: map['workouts'] != null
          ? List<Workout>.from(
              (map['workouts'] as List<dynamic>).map<Workout?>(
                (x) => Workout.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      diets: map['diets'] != null
          ? List<Diet>.from(
              (map['diets'] as List<dynamic>).map<Diet?>(
                (x) => Diet.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      packages: map['packages'] != null
          ? List<Package>.from(
              (map['packages'] as List<dynamic>).map<Package?>(
                (x) => Package.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      groups: map['groups'] != null
          ? List<Group>.from(
              (map['groups'] as List<dynamic>).map<Group?>(
                (x) => Group.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Gym.fromJson(String source) =>
      Gym.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Gym(id: $id, name: $name, gymCode: $gymCode, admins: $admins, trainers: $trainers, workouts: $workouts, diets: $diets, packages: $packages, groups: $groups)';
  }

  @override
  bool operator ==(covariant Gym other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.gymCode == gymCode &&
        listEquals(other.admins, admins) &&
        listEquals(other.trainers, trainers) &&
        listEquals(other.workouts, workouts) &&
        listEquals(other.diets, diets) &&
        listEquals(other.packages, packages) &&
        listEquals(other.groups, groups);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        gymCode.hashCode ^
        admins.hashCode ^
        trainers.hashCode ^
        workouts.hashCode ^
        diets.hashCode ^
        packages.hashCode ^
        groups.hashCode;
  }
}
