import 'dart:async';

import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _fire = FirebaseFirestore.instance;

  late final String currentUid;
  RxList<ChatModel> chatList = <ChatModel>[].obs;

  StreamSubscription? _subscription;

  @override
  void onInit() {
    super.onInit();
    currentUid = _auth.currentUser!.uid;
    _listenChats();
  }

  void _listenChats() {
    _subscription = _fire
        .collection('chats')
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: '${currentUid}_')
        .where(FieldPath.documentId, isLessThan: '${currentUid}_\uf8ff')
        .orderBy(FieldPath.documentId)
        .snapshots()
        .listen((snap) async {
      final list = <ChatModel>[];
      for (var doc in snap.docs) {
        final idParts = doc.id.split('_');
        if (idParts.length != 2 || idParts[0] != currentUid) continue;

        final contactId = idParts[1];
        final data = doc.data();
        final userSnap = await _fire.collection('users').doc(contactId).get();
        if (!userSnap.exists) continue;

        final contact = UserModel.fromJson(userSnap.data()!);
        list.add(ChatModel(
          chatId: doc.id,
          contactUserModel: contact,
          lastMsg: data['lastMsg'] ?? '',
          time: (data['timestamp'] as Timestamp).toDate(),
          unread: data['unread'] ?? 0,
          isPinned: data['isPinned'] ?? false,
        ));
      }
      chatList.assignAll(list);
      if (kDebugMode) print('Chats updated: ${list.length}');
    }, onError: (e) {
      Utils.toastMessage(message: 'Chat listener error: $e');
    });
  }

  Future<String> createMirroredChats(UserModel otherUser) async {
    final myUid = currentUid;
    final u2 = otherUser.uid;
    final id1 = '${myUid}_$u2';
    final id2 = '${u2}_$myUid';

    final ref1 = _fire.collection('chats').doc(id1);
    final ref2 = _fire.collection('chats').doc(id2);
    final batch = _fire.batch();

    final data = {
      'participants': [myUid, u2],
      'lastMsg': '',
      'timestamp': FieldValue.serverTimestamp(),
      'unread': 0,
      'isPinned': false,
    };

    if (!(await ref1.get()).exists) batch.set(ref1, data);
    if (!(await ref2.get()).exists) {
      batch.set(ref2, {
      ...data,
      'participants': [u2, myUid],
    });
    }

    await batch.commit();
    return id1;
  }

  Future<void> markMessagesAsRead(String chatId) async {

    // Only update the chat document that belongs to me (my perspective)
    await _fire.collection('chats').doc(chatId).update({'unread': 0});
  }


  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  List<ChatModel> get pinnedChats =>
      chatList.where((c) => c.isPinned).toList();

  List<ChatModel> get nonPinnedChats =>
      chatList.where((c) => !c.isPinned).toList();
}
