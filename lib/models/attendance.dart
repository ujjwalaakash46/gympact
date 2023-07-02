// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Attendance {
  final int id;
  final DateTime dateTime;
  final int userId;

  Attendance({
    required this.id,
    required this.dateTime,
    required this.userId,
  });

  Attendance copyWith({
    int? id,
    DateTime? dateTime,
    int? userId,
  }) {
    return Attendance(
      id: id ?? this.id,
      dateTime: dateTime ?? this.dateTime,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'dateTime': dateTime.millisecondsSinceEpoch,
      'userId': userId,
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      id: map['id'] as int,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
      userId: map['userId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) =>
      Attendance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Attendance(id: $id, dateTime: $dateTime, userId: $userId)';

  @override
  bool operator ==(covariant Attendance other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.dateTime == dateTime &&
        other.userId == userId;
  }

  @override
  int get hashCode => id.hashCode ^ dateTime.hashCode ^ userId.hashCode;
}
