// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Diet {
  final int id;
  final String name;
  final String note;
  final String protine;
  final String waterIntake;
  final String calIntake;
  final String calToBurn;

  Diet({
    required this.id,
    required this.name,
    required this.note,
    required this.protine,
    required this.waterIntake,
    required this.calIntake,
    required this.calToBurn,
  });

  Diet copyWith({
    int? id,
    String? name,
    String? note,
    String? protine,
    String? waterIntake,
    String? calIntake,
    String? calToBurn,
  }) {
    return Diet(
      id: id ?? this.id,
      name: name ?? this.name,
      note: note ?? this.note,
      protine: protine ?? this.protine,
      waterIntake: waterIntake ?? this.waterIntake,
      calIntake: calIntake ?? this.calIntake,
      calToBurn: calToBurn ?? this.calToBurn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'note': note,
      'protine': protine,
      'waterIntake': waterIntake,
      'calIntake': calIntake,
      'calToBurn': calToBurn,
    };
  }

  factory Diet.fromMap(Map<String, dynamic> map) {
    return Diet(
      id: map['id'] as int,
      name: map['name'] as String,
      note: map['note'] as String,
      protine: map['protine'] as String,
      waterIntake: map['waterIntake'] as String,
      calIntake: map['calIntake'] as String,
      calToBurn: map['calToBurn'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Diet.fromJson(String source) =>
      Diet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Diet(id: $id, name: $name, note: $note, protine: $protine, waterIntake: $waterIntake, calIntake: $calIntake, calToBurn: $calToBurn)';
  }

  @override
  bool operator ==(covariant Diet other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.note == note &&
        other.protine == protine &&
        other.waterIntake == waterIntake &&
        other.calIntake == calIntake &&
        other.calToBurn == calToBurn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        note.hashCode ^
        protine.hashCode ^
        waterIntake.hashCode ^
        calIntake.hashCode ^
        calToBurn.hashCode;
  }
}
