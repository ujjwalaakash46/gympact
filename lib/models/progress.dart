// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gympact/models/sub-progress/fat.dart';
import 'package:gympact/models/sub-progress/weight.dart';

class Progress {
  final int id;
  final List<Weight> weightList;
  final List<Fat> fatList;

  Progress({
    required this.id,
    required this.weightList,
    required this.fatList,
  });

  Progress copyWith({
    int? id,
    List<Weight>? weightList,
    List<Fat>? fatList,
  }) {
    return Progress(
      id: id ?? this.id,
      weightList: weightList ?? this.weightList,
      fatList: fatList ?? this.fatList,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'weightList': weightList.map((x) => x.toMap()).toList(),
      'fatList': fatList.map((x) => x.toMap()).toList(),
    };
  }

  factory Progress.fromMap(Map<String, dynamic> map) {
    return Progress(
      id: map['id'] as int,
      weightList: List<Weight>.from(
        (map['weightList'] as List<int>).map<Weight>(
          (x) => Weight.fromMap(x as Map<String, dynamic>),
        ),
      ),
      fatList: List<Fat>.from(
        (map['fatList'] as List<int>).map<Fat>(
          (x) => Fat.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Progress.fromJson(String source) =>
      Progress.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Progress(id: $id, weightList: $weightList, fatList: $fatList)';

  @override
  bool operator ==(covariant Progress other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        listEquals(other.weightList, weightList) &&
        listEquals(other.fatList, fatList);
  }

  @override
  int get hashCode => id.hashCode ^ weightList.hashCode ^ fatList.hashCode;
}
