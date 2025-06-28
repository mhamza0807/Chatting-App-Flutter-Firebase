import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel {
  final String uid;
  final String name;
  final String email;
  final String imgUrl;
  final bool isOnline;
  final DateTime? lastSeen;
  final List<String> friends;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.imgUrl,
    this.isOnline = false,
    this.lastSeen,
    this.friends = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'],
    name: json['name'],
    email: json['email'],
    imgUrl: json['imgUrl'],
    isOnline: json['isOnline'],
    lastSeen: (json['lastSeen'] as Timestamp?)?.toDate(),
    friends: List<String>.from(json['friends'] ?? []),
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'name': name,
    'email': email,
    'imgUrl': imgUrl,
    'isOnline': isOnline,
    'lastSeen': lastSeen,
    'friends': friends,
  };
}
