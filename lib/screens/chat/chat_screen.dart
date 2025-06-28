import 'package:chat_app/controllers/chat/chat_controller.dart';
import 'package:chat_app/controllers/chat/messages_controller.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/screens/chat/chat_appbar.dart';
import 'package:chat_app/screens/chat/display_chat.dart';
import 'package:chat_app/screens/chat/bottom_text_field.dart';
import 'package:chat_app/screens/errors/chat_not_found.dart';
import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home/home_controller.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final HomeController homeController = Get.find<HomeController>();
  final ChatController chatController = Get.find<ChatController>();
  final MessageController msgController = Get.put(MessageController());

  late final String chatId;
  ChatModel? chat;

  @override
  void initState() {
    super.initState();
    chatId = Get.arguments as String;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Wait until chatList is loaded
      final chatList = chatController.chatList;

      chat = chatList.firstWhereOrNull((c) => c.chatId == chatId);

      if (chat == null) {
        return const ChatNotFound();
      }
      if(chat!.unread > 0){
        chatController.markMessagesAsRead(chatId);
      }

      // Start listening to messages only once
      if (msgController.messages.isEmpty) {
        msgController.listenToMessages(chatId);
      }

      return Scaffold(
        backgroundColor: AppColors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ChatAppbar(chatModel: chat!),
            DisplayChat(chatModel: chat!),
            BottomTextField(chatModel: chat!),
          ],
        ),
      );
    });
  }
}

