import 'package:chat_app/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  final String chatId; // from Firestore
  final UserModel contactUserModel; // the other user in the chat
  final String lastMsg;
  final DateTime time; // for UI — you can also make it DateTime if needed
  final int unread;
  final bool isPinned;

  ChatModel({
    required this.chatId,
    required this.contactUserModel,
    required this.lastMsg,
    required this.time,
    this.unread = 0,
    this.isPinned = false,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json, UserModel user) {
    return ChatModel(
      chatId: json['chatId'],
      contactUserModel: user,
      lastMsg: json['lastMsg'] ?? '',
      time: (json['time'] as Timestamp).toDate(),
      unread: json['unread'] ?? 0,
      isPinned: json['isPinned'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'chatId': chatId,
    'lastMsg': lastMsg,
    'time': time,
    'unread': unread,
    'isPinned': isPinned,
  };
}
