import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

import '../../model/message_model.dart';

class MessageBubble extends StatefulWidget {
  final MessageModel message;
  const MessageBubble({super.key, required this.message});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:
          widget.message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
        child: getTextBubble(widget.message.isMe),
      ),
    );
  }

  Widget getTextBubble(bool isMe) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.8,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? AppColors.bubble2 : AppColors.bubble1,
          borderRadius: isMe
              ? BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          )
              : BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.message.text,
              style: TextStyle(
                fontSize: 20,
                color: isMe ? AppColors.white : AppColors.black,
              ),
            ),
            SizedBox(height: 6),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _formatTimestamp(widget.message.timestamp),
                    style: TextStyle(
                      fontSize: 12,
                      color: isMe ? AppColors.white : AppColors.black,
                    ),
                  ),
                  if (isMe) ...[
                    SizedBox(width: 5),
                    Icon(Icons.check, size: 16, color: AppColors.white),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }



  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }


}
