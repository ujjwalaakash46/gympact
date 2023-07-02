// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Weight {
  final int id;
  final int value;
  final DateTime dateTime;

  Weight({
    required this.id,
    required this.value,
    required this.dateTime,
  });

  Weight copyWith({
    int? id,
    int? value,
    DateTime? dateTime,
  }) {
    return Weight(
      id: id ?? this.id,
      value: value ?? this.value,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'value': value,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Weight.fromMap(Map<String, dynamic> map) {
    return Weight(
      id: map['id'] as int,
      value: map['value'] as int,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weight.fromJson(String source) =>
      Weight.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Weight(id: $id, value: $value, dateTime: $dateTime)';

  @override
  bool operator ==(covariant Weight other) {
    if (identical(this, other)) return true;

    return other.id == id && other.value == value && other.dateTime == dateTime;
  }

  @override
  int get hashCode => id.hashCode ^ value.hashCode ^ dateTime.hashCode;
}
