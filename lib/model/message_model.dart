import 'package:cloud_firestore/cloud_firestore.dart';
class MessageModel {
  final String messageId;
  final String chatId;
  final String senderId;
  final String text;
  final DateTime timestamp;
  final bool isMe; // for local use only — not stored in Firestore

  MessageModel({
    required this.messageId,
    required this.chatId,
    required this.senderId,
    required this.text,
    required this.timestamp,
    this.isMe = false,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json, String currentUserId) {
    return MessageModel(
      messageId: json['messageId'],
      chatId: json['chatId'],
      senderId: json['senderId'],
      text: json['text'],
      timestamp: (json['timestamp'] as Timestamp).toDate(),
      isMe: json['senderId'] == currentUserId,
    );
  }

  Map<String, dynamic> toJson() => {
    'messageId': messageId,
    'chatId': chatId,
    'senderId': senderId,
    'text': text,
    'timestamp': timestamp,
  };
}
