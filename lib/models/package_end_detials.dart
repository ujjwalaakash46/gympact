// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gympact/models/user.dart';

class PackageEndDetials {
  List<User>? packageEnded;
  List<User>? packageEndsIn;

  PackageEndDetials({
    this.packageEnded,
    this.packageEndsIn,
  });

  PackageEndDetials copyWith({
    List<User>? packageEnded,
    List<User>? packageEndsIn,
  }) {
    return PackageEndDetials(
      packageEnded: packageEnded ?? this.packageEnded,
      packageEndsIn: packageEndsIn ?? this.packageEndsIn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'packageEnded': packageEnded?.map((x) => x.toMap()).toList(),
      'packageEndsIn': packageEndsIn?.map((x) => x.toMap()).toList(),
    };
  }

  factory PackageEndDetials.fromMap(Map<String, dynamic> map) {
    return PackageEndDetials(
      packageEnded: map['packageEnded'] != null
          ? List<User>.from(
              (map['packageEnded'] as List<int>).map<User?>(
                (x) => User.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
      packageEndsIn: map['packageEndsIn'] != null
          ? List<User>.from(
              (map['packageEndsIn'] as List<int>).map<User?>(
                (x) => User.fromMap(x as Map<String, dynamic>),
              ),
            )
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PackageEndDetials.fromJson(String source) =>
      PackageEndDetials.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'PackageEndDetials(packageEnded: $packageEnded, packageEndsIn: $packageEndsIn)';

  @override
  bool operator ==(covariant PackageEndDetials other) {
    if (identical(this, other)) return true;

    return listEquals(other.packageEnded, packageEnded) &&
        listEquals(other.packageEndsIn, packageEndsIn);
  }

  @override
  int get hashCode => packageEnded.hashCode ^ packageEndsIn.hashCode;
}
