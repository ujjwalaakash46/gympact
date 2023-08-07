// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class Progress {
  int? id;
  final DateTime dateTime;
  double? weight;
  double? fat;
  double? calBurn;
  double? waterIntake;

  Progress({
    this.id,
    required this.dateTime,
    required this.weight,
    required this.fat,
    required this.calBurn,
    required this.waterIntake,
  });

  Progress copyWith({
    int? id,
    DateTime? dateTime,
    double? weight,
    double? fat,
    double? calBurn,
    double? waterIntake,
  }) {
    return Progress(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      weight: weight ?? this.weight,
      fat: fat ?? this.fat,
      calBurn: calBurn ?? this.calBurn,
      waterIntake: waterIntake ?? this.waterIntake,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateTime':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(dateTime).toString(),
      'weight': weight,
      'fat': fat,
      'calBurn': calBurn,
      'waterIntake': waterIntake,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map['id'] as int,
      dateTime: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['dateTime']),
      weight: map['weight'] != null ? map['weight'] as double : null,
      fat: map['fat'] != null ? map['fat'] as double : null,
      calBurn: map['calBurn'] != null ? map['calBurn'] as double : null,
      waterIntake:
          map['waterIntake'] != null ? map['waterIntake'] as double : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Progress.fromJson(String source) =>
      Progress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Progress(id: $id, dateTime: $dateTime, weight: $weight, fat: $fat, calBurn: $calBurn, waterIntake: $waterIntake)';
  }

  @override
  bool operator ==(covariant Progress other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.dateTime == dateTime &&
        other.weight == weight &&
        other.fat == fat &&
        other.calBurn == calBurn &&
        other.waterIntake == waterIntake;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        dateTime.hashCode ^
        weight.hashCode ^
        fat.hashCode ^
        calBurn.hashCode ^
        waterIntake.hashCode;
  }
}
