import 'package:chat_app/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../controllers/home/home_controller.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({super.key});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  final HomeController hc = Get.find<HomeController>();

  /// Ensures consistent call ID for both users
  String _getSortedCallId(String chatId) {
    final parts = chatId.split('_');
    if (parts.length == 2) {
      parts.sort();
      return '${parts[0]}_${parts[1]}';
    }
    return chatId;
  }

  @override
  Widget build(BuildContext context) {
    final String chatId = Get.arguments ?? '';
    final String callId = _getSortedCallId(chatId);
    final String userId = hc.currentUid;
    final String userName = hc.user.displayName ?? 'User';

    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: Consts.appId,
          appSign: Consts.appSign,
          callID: callId,      // ✅ shared room ID for both users
          userID: userId,      // ✅ current user's ID
          userName: 'user',  // ✅ current user's name
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
        ),
      ),
    );
  }
}
