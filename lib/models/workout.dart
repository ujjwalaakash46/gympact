// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gympact/models/exercise.dart';

class Workout {
  final int id;
  final String gymId;
  final String name;
  final String discription;
  final String note;
  final DateTime createdDate;
  final DateTime updatedDate;
  final List<Exercise> exercises;

  Workout({
    required this.id,
    required this.gymId,
    required this.name,
    required this.discription,
    required this.note,
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
    DateTime? createdDate,
    DateTime? updatedDate,
    List<Exercise>? exercises,
  }) {
    return Workout(
      id: id ?? this.id,
      gymId: gymId ?? this.gymId,
      name: name ?? this.name,
      discription: discription ?? this.discription,
      note: note ?? this.note,
      createdDate: createdDate ?? this.createdDate,
      updatedDate: updatedDate ?? this.updatedDate,
      exercises: exercises ?? this.exercises,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'gymId': gymId,
      'name': name,
      'discription': discription,
      'note': note,
      'createdDate': createdDate.millisecondsSinceEpoch,
      'updatedDate': updatedDate.millisecondsSinceEpoch,
      'exercises': exercises.map((x) => x.toMap()).toList(),
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'] as int,
      gymId: map['gymId'] as String,
      name: map['name'] as String,
      discription: map['discription'] as String,
      note: map['note'] as String,
      createdDate:
          DateTime.fromMillisecondsSinceEpoch(map['createdDate'] as int),
      updatedDate:
          DateTime.fromMillisecondsSinceEpoch(map['updatedDate'] as int),
      exercises: List<Exercise>.from(
        (map['exercises'] as List<int>).map<Exercise>(
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
    return 'Workout(id: $id, gymId: $gymId, name: $name, discription: $discription, note: $note, createdDate: $createdDate, updatedDate: $updatedDate, exercises: $exercises)';
  }

  @override
  bool operator ==(covariant Workout other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.gymId == gymId &&
        other.name == name &&
        other.discription == discription &&
        other.note == note &&
        other.createdDate == createdDate &&
        other.updatedDate == updatedDate &&
        listEquals(other.exercises, exercises);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        gymId.hashCode ^
        name.hashCode ^
        discription.hashCode ^
        note.hashCode ^
        createdDate.hashCode ^
        updatedDate.hashCode ^
        exercises.hashCode;
  }
}
