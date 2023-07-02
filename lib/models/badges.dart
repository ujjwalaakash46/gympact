// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Badges {
  final int id;
  final String name;
  final String img;
  final DateTime date;

  Badges({
    required this.id,
    required this.name,
    required this.img,
    required this.date,
  });

  Badges copyWith({
    int? id,
    String? name,
    String? img,
    DateTime? date,
  }) {
    return Badges(
      id: id ?? this.id,
      name: name ?? this.name,
      img: img ?? this.img,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'img': img,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory Badges.fromMap(Map<String, dynamic> map) {
    return Badges(
      id: map['id'] as int,
      name: map['name'] as String,
      img: map['img'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Badges.fromJson(String source) =>
      Badges.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Badges(id: $id, name: $name, img: $img, date: $date)';
  }

  @override
  bool operator ==(covariant Badges other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.img == img &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ img.hashCode ^ date.hashCode;
  }
}
