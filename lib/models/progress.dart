// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Progress {
  final int id;
  final DateTime dateTime;
  final double weight;
  final double fat;
  final double calBurn;
  final double waterIntake;

  Progress({
    required this.id,
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
      'dateTime': dateTime.millisecondsSinceEpoch,
      'weight': weight,
      'fat': fat,
      'calBurn': calBurn,
      'waterIntake': waterIntake,
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map['id'] as int,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      weight: map['weight'] as double,
      fat: map['fat'] as double,
      calBurn: map['calBurn'] as double,
      waterIntake: map['waterIntake'] as double,
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
