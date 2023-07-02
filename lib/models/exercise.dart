// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Exercise {
  final int id;
  final String name;
  final String note;
  final int sets;
  final int reps;
  final int weight;

  Exercise(
    this.id,
    this.name,
    this.note,
    this.sets,
    this.reps,
    this.weight,
  );

  Exercise copyWith({
    int? id,
    String? name,
    String? note,
    int? sets,
    int? reps,
    int? weight,
  }) {
    return Exercise(
      id ?? this.id,
      name ?? this.name,
      note ?? this.note,
      sets ?? this.sets,
      reps ?? this.reps,
      weight ?? this.weight,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'note': note,
      'sets': sets,
      'reps': reps,
      'weight': weight,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      map['id'] as int,
      map['name'] as String,
      map['note'] as String,
      map['sets'] as int,
      map['reps'] as int,
      map['weight'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Exercise.fromJson(String source) =>
      Exercise.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Exercise(id: $id, name: $name, note: $note, sets: $sets, reps: $reps, weight: $weight)';
  }

  @override
  bool operator ==(covariant Exercise other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.note == note &&
        other.sets == sets &&
        other.reps == reps &&
        other.weight == weight;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        note.hashCode ^
        sets.hashCode ^
        reps.hashCode ^
        weight.hashCode;
  }
}
