// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Package {
  int? id;
  final double price;
  final int durationInMonths;
  final String name;
  final List<String> benefits;
  Package({
    this.id,
    required this.price,
    required this.durationInMonths,
    required this.name,
    required this.benefits,
  });

  Package copyWith({
    int? id,
    double? price,
    int? durationInMonths,
    String? name,
    List<String>? benefits,
  }) {
    return Package(
      id: id ?? this.id,
      price: price ?? this.price,
      durationInMonths: durationInMonths ?? this.durationInMonths,
      name: name ?? this.name,
      benefits: benefits ?? this.benefits,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'durationInMonths': durationInMonths,
      'name': name,
      'benefits': benefits,
    };
  }

  factory Package.fromMap(Map<String, dynamic> map) {
    return Package(
      id: map['id'] as int,
      price: map['price'] as double,
      durationInMonths: map['durationInMonths'] as int,
      name: map['name'] as String,
      benefits: List<String>.from((map['benefits'] as List<dynamic>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory Package.fromJson(String source) =>
      Package.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Package(id: $id, price: $price, durationInMonths: $durationInMonths, name: $name, benefits: $benefits)';
  }

  @override
  bool operator ==(covariant Package other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.price == price &&
        other.durationInMonths == durationInMonths &&
        other.name == name &&
        listEquals(other.benefits, benefits);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        durationInMonths.hashCode ^
        name.hashCode ^
        benefits.hashCode;
  }
}
