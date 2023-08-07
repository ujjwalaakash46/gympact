// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gympact/models/exercise.dart';
import 'package:intl/intl.dart';

class Workout {
  int? id;
  final String name;
  final String discription;
  final String note;
  final int durationInMin;
  final DateTime createdDate;
  final DateTime updatedDate;
  final List<Exercise> exercises;
  //added by user

  Workout({
    this.id,
    required this.name,
    required this.discription,
    required this.note,
    required this.durationInMin,
    required this.createdDate,
    required this.updatedDate,
    required this.exercises,
  });

  Workout copyWith({
    int? id,
    String? gymId,
    String? name,
    String? discription,
    String? note,
    int? durationInMin,
    DateTime? createdDate,
    DateTime? updatedDate,
    List<Exercise>? exercises,
  }) {
    return Workout(
      id: id ?? this.id,
      name: name ?? this.name,
      discription: discription ?? this.discription,
      note: note ?? this.note,
      durationInMin: durationInMin ?? this.durationInMin,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'discription': discription,
      'note': note,
      'durationInMin': durationInMin,
      'createdDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
          .format(createdDate)
          .toString(),
      'updatedDate': DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS")
          .format(updatedDate)
          .toString(),
      'exercises': exercises.map((x) => x.toMap()).toList(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] as int,
      name: map['name'] as String,
      discription: map['discription'] as String,
      note: map['note'] as String,
      durationInMin: map['durationInMin'] as int,
      createdDate: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['createdDate']),
      updatedDate: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['updatedDate']),
      exercises: List<Exercise>.from(
        (map['exercises'] as List<dynamic>).map<Exercise>(
          (x) => Exercise.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Workout.fromJson(String source) =>
      Workout.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Workout(id: $id, name: $name, discription: $discription, note: $note, durationInMin: $durationInMin, createdDate: $createdDate, updatedDate: $updatedDate, exercises: $exercises)';
  }

  @override
  bool operator ==(covariant Workout other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.discription == discription &&
        other.note == note &&
        other.durationInMin == durationInMin &&
        other.createdDate == createdDate &&
        other.updatedDate == updatedDate &&
        listEquals(other.exercises, exercises);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        discription.hashCode ^
        note.hashCode ^
        durationInMin.hashCode ^
        createdDate.hashCode ^
        updatedDate.hashCode ^
        exercises.hashCode;
  }
}
