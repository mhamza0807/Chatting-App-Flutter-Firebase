import 'dart:async';

import 'package:chat_app/model/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageController extends GetxController {
  RxBool isSending = false.obs;

  final _auth = FirebaseAuth.instance;
  final _fire = FirebaseFirestore.instance;
  RxString typedValue = ''.obs;

  Rx<TextEditingController> typedText = TextEditingController().obs;
  late final String myUserId;
  RxList<MessageModel> messages = <MessageModel>[].obs;

  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    myUserId = _auth.currentUser!.uid;
    // Listen to changes inside the controller
    typedText.value.addListener(() {
      typedValue.value = typedText.value.text;
    });
  }

  void listenToMessages(String chatId) {
    _sub?.cancel();
    _sub = _fire
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp')
        .snapshots()
        .listen(
          (snap) {
            messages.assignAll(
              snap.docs.map((d) => MessageModel.fromJson(d.data(), myUserId)),
            );
            // print('Here: $messages');
          },
          onError: (e) {
            Get.snackbar('Error', 'Msg listener error: $e');
          },
        );
  }

  Future<void> sendMessage({
    required String chatId,
    required String text,
  }) async {
    final ids = chatId.split('_');
    if (ids.length != 2 || isSending.value) return;

    isSending.value = true;
    final other = ids.firstWhere((id) => id != myUserId);
    final mirrorId = '${other}_$myUserId';

    final mid =
        _fire.collection('chats').doc(chatId).collection('messages').doc().id;
    final msg = MessageModel(
      messageId: mid,
      chatId: chatId,
      senderId: myUserId,
      text: text,
      timestamp: DateTime.now(),
      isMe: true,
    );
    final mMap = msg.toJson();

    final b = _fire.batch();
    b.set(
      _fire.collection('chats').doc(chatId).collection('messages').doc(mid),
      mMap,
    );

    final mirrorMap =
        Map<String, dynamic>.from(mMap)
          ..['isMe'] = false
          ..['chatId'] = mirrorId;

    b.set(
      _fire.collection('chats').doc(mirrorId).collection('messages').doc(mid),
      mirrorMap,
    );

    final update = {
      'lastMsg': text,
      'timestamp': FieldValue.serverTimestamp(),
      'unread': FieldValue.increment(1),
    };
    b.update(_fire.collection('chats').doc(chatId), update);
    b.update(_fire.collection('chats').doc(mirrorId), update);

    await b.commit();
    isSending.value = false;

    typedText.value.clear();
  }

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
