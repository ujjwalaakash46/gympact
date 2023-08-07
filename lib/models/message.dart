// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:convert';

// class Message {
//   int? id;
// 	DateTime createdOn;
// 	String data;
//   Message({
//     this.id,
//     required this.createdOn,
//     required this.data,
//   });

//   Message copyWith({
//     int? id,
//     DateTime? createdOn,
//     String? data,
//   }) {
//     return Message(
//       id: id ?? this.id,
//       createdOn: createdOn ?? this.createdOn,
//       data: data ?? this.data,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'id': id,
//       'createdOn': createdOn.millisecondsSinceEpoch,
//       'data': data,
//     };
//   }

//   factory Message.fromMap(Map<String, dynamic> map) {
//     return Message(
//       id: map['id'] != null ? map['id'] as int : null,
//       createdOn: DateTime.fromMillisecondsSinceEpoch(map['createdOn'] as int),
//       data: map['data'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Message.fromJson(String source) => Message.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Message(id: $id, createdOn: $createdOn, data: $data)';

//   @override
//   bool operator ==(covariant Message other) {
//     if (identical(this, other)) return true;
  
//     return 
//       other.id == id &&
//       other.createdOn == createdOn &&
//       other.data == data;
//   }

//   @override
//   int get hashCode => id.hashCode ^ createdOn.hashCode ^ data.hashCode;
// }
