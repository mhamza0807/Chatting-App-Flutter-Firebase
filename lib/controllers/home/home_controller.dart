import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../model/chat_model.dart';
import '../../model/user_model.dart';
import '../../utils/utils.dart';
import '../chat/chat_controller.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../model/chat_model.dart';
import '../../model/user_model.dart';
import '../../utils/utils.dart';
import '../chat/chat_controller.dart';

class HomeController extends GetxController {
  final _auth = FirebaseAuth.instance;
  final _fire = FirebaseFirestore.instance;

  late final String currentUid;
  late final User user;

  Rxn<UserModel> myUser = Rxn<UserModel>();
  RxList<UserModel> userList = <UserModel>[].obs;
  RxList<ChatModel> chatList = <ChatModel>[].obs;
  RxString activeTab = 'All Messages'.obs;

  @override
  void onInit() async {
    super.onInit();
    user = _auth.currentUser!;
    currentUid = user.uid;

    await fetchMyDetails();
    await fetchAllUsers();

    final chatCtrl = Get.put(ChatController());
    chatCtrl.chatList.listen((list) {
      chatList.assignAll(list);
    });
  }

  Future<void> fetchMyDetails() async {
    final doc = await _fire.collection('users').doc(currentUid).get();
    if (doc.exists) {
      myUser.value = UserModel.fromJson(doc.data()!);
      if (kDebugMode) print('Fetched my data: ${myUser.value!.name}');
    } else {
      Utils.toastMessage(message: 'User data not found.');
    }
  }

  Future<void> fetchAllUsers() async {
    final qs = await _fire.collection('users').get();
    userList.assignAll(
      qs.docs
          .where((d) => d.id != currentUid)
          .map((d) => UserModel.fromJson(d.data()))
          .toList(),
    );
  }

  void changeTab(String tab) => activeTab.value = tab;

  void searchUserByEmail(String email) async {
    final qs =
        await _fire
            .collection('users')
            .where('email', isEqualTo: email.trim())
            .get();
    if (qs.docs.isEmpty) {
      Get.snackbar('Not Found', 'No user found with email');
      return;
    }
    final other = UserModel.fromJson(qs.docs.first.data());
    final chatCtrl = Get.find<ChatController>();
    final chatId = await chatCtrl.createMirroredChats(other);
    Get.toNamed('/chat_screen', arguments: chatId);
  }

  ChatModel? getChatWithUid(String uid) {
    return chatList.firstWhereOrNull((c) => c.contactUserModel.uid == uid);
  }

  void setSelectedTab(String tab) => activeTab.value = tab;
}
