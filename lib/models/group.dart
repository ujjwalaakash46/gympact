// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gympact/models/user.dart';
import 'package:intl/intl.dart';

class Group {
  int? id;
  String name;
  List<User> members;
  int totalMembers;
  List<Message> messages;
  Group({
    this.id,
    required this.name,
    required this.members,
    required this.totalMembers,
    required this.messages,
  });

  Group copyWith({
    int? id,
    int? gymId,
    String? name,
    List<User>? members,
    int? totalMembers,
    List<Message>? messages,
  }) {
    return Group(
      id: id ?? this.id,
      name: name ?? this.name,
      members: members ?? this.members,
      totalMembers: totalMembers ?? this.totalMembers,
      messages: messages ?? this.messages,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'members': members.map((x) => x.toMap()).toList(),
      'totalMembers': totalMembers,
      'messages': messages.map((x) => x.toMap()).toList(),
    };
  }

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      members: List<User>.from(
        (map['members'] as List<dynamic>).map<User>(
          (x) => User.fromMap(x as Map<String, dynamic>),
        ),
      ),
      totalMembers: map['totalMembers'] as int,
      messages: List<Message>.from(
        (map['messages'] as List<dynamic>).map<Message>(
          (x) => Message.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Group.fromJson(String source) =>
      Group.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Group(id: $id, name: $name, members: $members, totalMembers: $totalMembers, messages: $messages)';
  }

  @override
  bool operator ==(covariant Group other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        listEquals(other.members, members) &&
        other.totalMembers == totalMembers &&
        listEquals(other.messages, messages);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        members.hashCode ^
        totalMembers.hashCode ^
        messages.hashCode;
  }
}

class Message {
  int? id;
  DateTime createdOn;
  String data;
  Message({
    this.id,
    required this.createdOn,
    required this.data,
  });

  Message copyWith({
    int? id,
    DateTime? createdOn,
    String? data,
  }) {
    return Message(
      id: id ?? this.id,
      createdOn: createdOn ?? this.createdOn,
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'createdOn':
          DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(createdOn).toString(),
      'data': data,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'] != null ? map['id'] as int : null,
      createdOn: DateFormat("yyyy-MM-ddTHH:mm:ssZ").parse(map['createdOn']),
      data: map['data'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Message(id: $id, createdOn: $createdOn, data: $data)';

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.id == id && other.createdOn == createdOn && other.data == data;
  }

  @override
  int get hashCode => id.hashCode ^ createdOn.hashCode ^ data.hashCode;
}
