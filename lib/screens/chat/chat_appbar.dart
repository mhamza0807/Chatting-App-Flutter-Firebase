import 'package:chat_app/model/chat_model.dart';
import 'package:chat_app/screens/chat/user_detail_sheet.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/permissions/calling.dart';
import '../../utils/app_colors.dart';

class ChatAppbar extends StatefulWidget {
  final ChatModel chatModel;
  const ChatAppbar({super.key, required this.chatModel});

  @override
  State<ChatAppbar> createState() => _ChatAppbarState();
}

class _ChatAppbarState extends State<ChatAppbar> {
  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Container(
      width: double.infinity,
      height: size.height * 0.18,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.65, 1.0],
          colors: [
            AppColors.purpleDark,
            AppColors.purpleDark.withOpacity(0.88),
            AppColors.purpleLight,
          ],
        ),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Top right - big
          Positioned(
            top: -size.height * 0.1,
            right: -size.height * 0.12,
            child: Container(
              width: size.height * 0.25,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.04),
              ),
            ),
          ),

          // Top right - small overlap
          Positioned(
            top: -size.height * 0.18,
            right: -size.height * 0.05,
            child: Container(
              width: size.height * 0.28,
              height: size.height * 0.28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.025),
              ),
            ),
          ),

          //main thing here
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: size.height * 0.11,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Left rounded part
                  Expanded(
                    flex: 6,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: AppColors.grey, // Set your desired color
                            width: 2.0, // Set desired thickness
                          ),
                        ),
                        color: AppColors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: GestureDetector(
                                onTap: () => Get.back(),
                                child: Icon(Icons.arrow_back_ios_new),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: CircleAvatar(
                              radius: 23,
                              backgroundImage: NetworkImage(
                                widget.chatModel.contactUserModel.imgUrl,
                              ),
                              backgroundColor: Colors.grey.shade300,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                widget.chatModel.contactUserModel.name.length >
                                        13
                                    ? '${widget.chatModel.contactUserModel.name.substring(0, 11)}...'
                                    : widget.chatModel.contactUserModel.name,
                                style: TextStyle(
                                  color: AppColors.purpleDark,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Roboto',
                                  fontSize: 20,
                                ),
                              ),
                              widget.chatModel.contactUserModel.isOnline
                                  ? Text(
                                    'Online',
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  )
                                  : Text(
                                    'Last seen ${_formatTimestamp(widget.chatModel.contactUserModel.lastSeen!)}',
                                  ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Action buttons
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (await requestMicPermission()) {
                              Get.toNamed(
                                '/audio_call',
                                arguments: widget.chatModel.chatId,
                              );
                            } else {
                              Utils.toastMessage(
                                message: 'Audio Permission not granted',
                              );
                            }
                          },

                          child: Icon(
                            Icons.call_outlined,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            final granted = await requestCameraAndMicPermissions();
                            if (granted) {
                              Get.toNamed('/video_call', arguments: widget.chatModel.chatId);
                            } else {
                              Utils.toastMessage(message: 'Camera/Mic permission not granted');
                            }
                          },
                          child: Icon(
                            Icons.video_call_outlined,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                        GestureDetector(
                          onTap:
                              () => showUserDetailSheet(
                                context,
                                widget.chatModel.contactUserModel,
                              ),
                          child: Icon(
                            Icons.person,
                            color: AppColors.white,
                            size: 25,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //------------------------------

          // Small dots scattered throughout
          ...List.generate(15, (index) {
            final positions = [
              {'top': size.height * 0.05, 'left': size.width * 0.1},
              {'top': size.height * 0.05, 'left': size.width * 0.3},
              {'top': size.height * 0.08, 'left': size.width * 0.7},
              {'top': size.height * 0.12, 'left': size.width * 0.2},
              {'top': size.height * 0.15, 'left': size.width * 0.8},
              {'top': size.height * 0.18, 'left': size.width * 0.4},
              {'top': size.height * 0.22, 'left': size.width * 0.6},
              {'top': size.height * 0.25, 'left': size.width * 0.15},
              {'top': size.height * 0.03, 'left': size.width * 0.5},
              {'top': size.height * 0.07, 'left': size.width * 0.85},
              {'top': size.height * 0.11, 'left': size.width * 0.05},
              {'top': size.height * 0.16, 'left': size.width * 0.25},
              {'top': size.height * 0.20, 'left': size.width * 0.75},
              {'top': size.height * 0.24, 'left': size.width * 0.45},
              {'top': size.height * 0.27, 'left': size.width * 0.65},
            ];

            return Positioned(
              top: positions[index]['top'],
              left: positions[index]['left'],
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
