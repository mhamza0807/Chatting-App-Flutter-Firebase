import 'package:chat_app/controllers/chat/messages_controller.dart';
import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomTextField extends StatelessWidget {
  final ChatModel chatModel;
  BottomTextField({super.key, required this.chatModel});

  final MessageController msgController = Get.find();
  final size = Get.size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.14,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
        color: AppColors.typeMessagePink,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Obx(() => TextField(
                controller: msgController.typedText.value,
                decoration: InputDecoration(
                  hintText: 'Type message...',
                  hintStyle: TextStyle(color: AppColors.black),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white70),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.emoji_emotions_outlined,
                          color: AppColors.black),
                      const SizedBox(width: 8),
                      Icon(Icons.attach_file, color: AppColors.black),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
                style: TextStyle(color: AppColors.black),
              )),
            ),
            const SizedBox(width: 10),
            Obx(() {
              final typed = msgController.typedValue.value.trim();
              return GestureDetector(
                onTap: () {
                  if (typed.isNotEmpty) {
                    msgController.sendMessage(
                      chatId: chatModel.chatId,
                      text: typed,
                    );
                  }
                },
                child: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.purpleDark, AppColors.purpleLight],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: typed.isEmpty
                        ? Icon(Icons.mic_none, color: AppColors.white)
                        : Icon(Icons.send_outlined, color: AppColors.white),
                  ),
                ),
              );
            })

          ],
        ),
      ),
    );
  }
}
