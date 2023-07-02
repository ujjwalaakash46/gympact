// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gympact/models/package.dart';

class CurrentPackage {
  final int id;
  final Package package;
  final DateTime startDate;
  final DateTime endDate;

  CurrentPackage({
    required this.id,
    required this.package,
    required this.startDate,
    required this.endDate,
  });

  CurrentPackage copyWith({
    int? id,
    Package? package,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return CurrentPackage(
      id: id ?? this.id,
      package: package ?? this.package,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'package': package.toMap(),
      'startDate': startDate.millisecondsSinceEpoch,
      'endDate': endDate.millisecondsSinceEpoch,
    };
  }

  factory CurrentPackage.fromMap(Map<String, dynamic> map) {
    return CurrentPackage(
      id: map['id'] as int,
      package: Package.fromMap(map['package'] as Map<String, dynamic>),
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate'] as int),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentPackage.fromJson(String source) =>
      CurrentPackage.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CurrentPackage(id: $id, package: $package, startDate: $startDate, endDate: $endDate)';
  }

  @override
  bool operator ==(covariant CurrentPackage other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.package == package &&
        other.startDate == startDate &&
        other.endDate == endDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        package.hashCode ^
        startDate.hashCode ^
        endDate.hashCode;
  }
}
