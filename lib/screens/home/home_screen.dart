import 'package:chat_app/controllers/chat/chat_controller.dart';
import 'package:chat_app/controllers/home/home_controller.dart';
import 'package:chat_app/screens/home/chat_tile.dart';
import 'package:chat_app/screens/home/header_divider.dart';
import 'package:chat_app/screens/home/row_slider.dart';
import 'package:chat_app/screens/home/search.dart';
import 'package:chat_app/screens/home/top_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final homeController = Get.put(HomeController());
  final chatController = Get.put(ChatController());

  final List<String> tabTitles = [
    'All Messages',
    'Unread Messages',
    'Starred',
    'Archived',
  ];

  @override
  Widget build(BuildContext context) {
    final size = Get.size;

    if (kDebugMode) {
      print(FirebaseAuth.instance.currentUser!.displayName);
    }

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Purple top
            TopContainer(),
            SizedBox(height: size.height * 0.02),

            Search(),
            SizedBox(height: size.height * 0.02),

            // Slide tabs
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => homeController.setSelectedTab('All Messages'),
                    child: HomeRowContainer(
                      text: 'All Messages',
                      activeTab: homeController.activeTab.value,
                    ),
                  ),
                  InkWell(
                    onTap: () => homeController.setSelectedTab('Unread Messages'),
                    child: HomeRowContainer(
                      text: 'Unread Messages',
                      activeTab: homeController.activeTab.value,
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(height: size.height * 0.02),

            // Header Divider
            HeaderDivider(text: 'Pinned Messages'),
            SizedBox(height: size.height * 0.02),

            // Pinned Chats
            Obx(() {
              final pinnedChats = chatController.pinnedChats;
              if (pinnedChats.isEmpty) {
                return Center(child: Text('No pinned messages yet.'));
              }
              return Column(
                children: pinnedChats.map((chat) {
                  return Column(
                    children: [
                      ChatTile(
                        imgUrl: chat.contactUserModel.imgUrl,
                        name: chat.contactUserModel.name,
                        lastMsg: chat.lastMsg,
                        time: chat.time.toString(),
                        unread: chat.unread,
                        isOnline: chat.contactUserModel.isOnline,
                        onTap: () {
                          Get.toNamed('/chat_screen', arguments: chat.chatId);
                        },
                      ),
                      Divider(
                        color: AppColors.grey,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ],
                  );
                }).toList(),
              );
            }),

            SizedBox(height: size.height * 0.02),

            // All Messages
            HeaderDivider(text: 'All Messages'),
            SizedBox(height: size.height * 0.02),

            Obx(() {
              final allChats = chatController.nonPinnedChats;
              if (allChats.isEmpty) {
                return Center(child: Text('No chats yet.'));
              }
              return Column(
                children: allChats.map((chat) {
                  return Column(
                    children: [
                      ChatTile(
                        imgUrl: chat.contactUserModel.imgUrl,
                        name: chat.contactUserModel.name,
                        lastMsg: chat.lastMsg,
                        time: chat.time.toString(),
                        unread: chat.unread,
                        isOnline: chat.contactUserModel.isOnline,
                        onTap: () {
                          Get.toNamed('/chat_screen', arguments: chat.chatId);
                        },
                      ),
                      Divider(
                        color: AppColors.grey,
                        thickness: 2,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ],
                  );
                }).toList(),
              );
            }),

            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }
}
