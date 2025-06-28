import 'package:chat_app/utils/consts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../controllers/home/home_controller.dart';

class AudioCall extends StatefulWidget {
  const AudioCall({super.key});

  @override
  State<AudioCall> createState() => _AudioCallState();
}

class _AudioCallState extends State<AudioCall> {
  final HomeController hc = Get.find<HomeController>();

  /// Always returns consistent call ID (sorted user IDs)
  String _getSortedCallId(String chatId) {
    final parts = chatId.split('_');
    if (parts.length == 2) {
      parts.sort(); // ensures same order for both users
      return '${parts[0]}_${parts[1]}';
    }
    return chatId;
  }

  @override
  Widget build(BuildContext context) {
    final String chatId = Get.arguments ?? '';
    final String callId = _getSortedCallId(chatId);
    final String userId = hc.currentUid;

    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltCall(
          appID: Consts.appId,
          appSign: Consts.appSign,
          callID: callId,
          userID: userId,
          userName: 'User',
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
        ),
      ),
    );
  }
}
