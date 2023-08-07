// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:gympact/models/package.dart';
import 'package:intl/intl.dart';

class CurrentPackage {
  int? id;
  final Package package;
  final DateTime startDate;
  final DateTime endDate;

  CurrentPackage({
    this.id,
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
      'packageDetails': package.toMap(),
      'startDate':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(startDate).toString(),
      'endDate':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(endDate).toString(),
    };
  }

  factory CurrentPackage.fromMap(Map<String, dynamic> map) {
    return CurrentPackage(
        id: map['id'] as int,
        package: Package.fromMap(map['packageDetails'] as Map<String, dynamic>),
        startDate: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['startDate']),
        endDate: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(
          (map['endDate']),
        ));
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
