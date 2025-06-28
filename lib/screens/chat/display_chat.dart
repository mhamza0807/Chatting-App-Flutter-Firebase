import 'package:chat_app/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/chat/messages_controller.dart';
import '../../utils/app_colors.dart';
import 'message_bubble.dart';

class DisplayChat extends StatefulWidget {
  final ChatModel chatModel;

  DisplayChat({super.key, required this.chatModel});

  @override
  State<DisplayChat> createState() => _DisplayChatState();
}

class _DisplayChatState extends State<DisplayChat> {
  final MessageController msgController = Get.find();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    msgController.listenToMessages(widget.chatModel.chatId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        color: AppColors.white,
        child: Obx(() {
          final filteredMessages = msgController.messages
              .where((msg) => msg.chatId == widget.chatModel.chatId)
              .toList();

          // Auto-scroll to the bottom after widget builds
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.hasClients) {
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
          });

          return ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.only(bottom: 80),
            itemCount: filteredMessages.length,
            itemBuilder: (context, index) {
              return MessageBubble(message: filteredMessages[index]);
            },
          );
        }),
      ),
    );
  }
}
