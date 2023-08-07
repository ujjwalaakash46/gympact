// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:intl/intl.dart';

class Fat {
  final int id;
  final int value;
  final DateTime dateTime;

  Fat({
    required this.id,
    required this.value,
    required this.dateTime,
  });

  Fat copyWith({
    int? id,
    int? value,
    DateTime? dateTime,
  }) {
    return Fat(
      id: id ?? this.id,
      value: value ?? this.value,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  factory Fat.fromMap(Map<String, dynamic> map) {
    return Fat(
      id: map['id'] as int,
      value: map['value'] as int,
      dateTime: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['dateTime']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Fat.fromJson(String source) =>
      Fat.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Fat(id: $id, value: $value, dateTime: $dateTime)';

  @override
  bool operator ==(covariant Fat other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value && other.dateTime == dateTime;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ dateTime.hashCode;
}
