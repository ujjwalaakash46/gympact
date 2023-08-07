// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gympact/models/workout.dart';
import 'package:intl/intl.dart';

class PastWorkout {
  int? id;
  final DateTime dateTime;
  final Workout workout;
  //percentage conpleted.
  PastWorkout({
    this.id,
    required this.dateTime,
    required this.workout,
  });

  PastWorkout copyWith({
    int? id,
    DateTime? dateTime,
    Workout? workout,
  }) {
    return PastWorkout(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      workout: workout ?? this.workout,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateTime':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dateTime).toString(),
      'workout': workout.toMap(),
    };
  }

  factory PastWorkout.fromMap(Map<String, dynamic> map) {
    return PastWorkout(
      id: map['id'] as int,
      dateTime: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['dateTime']),
      workout: Workout.fromMap(map['workout'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory PastWorkout.fromJson(String source) =>
      PastWorkout.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PastWorkout(id: $id, dateTime: $dateTime, workout: $workout)';

  @override
  bool operator ==(covariant PastWorkout other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.dateTime == dateTime &&
        other.workout == workout;
  }

  @override
  int get hashCode => id.hashCode ^ dateTime.hashCode ^ workout.hashCode;
}
