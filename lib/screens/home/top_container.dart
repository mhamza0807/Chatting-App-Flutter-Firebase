import 'package:chat_app/controllers/home/home_controller.dart';
import 'package:chat_app/model/user_model.dart';
import 'package:chat_app/services/auth_services/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

class TopContainer extends StatefulWidget {
  const TopContainer({super.key});

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  HomeController hc = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = Get.size;
    return Container(
      width: double.infinity,
      height: size.height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
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

          //Left bottom - big
          Positioned(
            top: size.height * 0.11,
            left: -size.height * 0.26,
            child: Container(
              width: size.height * 0.55,
              height: size.height * 0.4,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
              ),
            ),
          ),

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

          Positioned(
            top: size.height * 0.08,
            left: size.width * 0.05,
            child: Obx(() {
              final user = hc.myUser.value;
              return Text(
                user == null ? 'Hello ...' : 'Hello ${user.name}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white.withOpacity(0.8),
                ),
              );
            }),
          ),

          Positioned(
            top: size.height * 0.115,
            left: size.width * 0.05,
            child: Text(
              '55 Unread Messages',
              style: TextStyle(
                fontSize: 28,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.1,
            right: size.width * 0.05,
            child: GestureDetector(
              onTap: () => AuthGate().logout(),
              child: Icon(
                Icons.logout_outlined,
                color: AppColors.white,
                size: 28,
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.2,
            left: 10,
            right: 10,
            child: Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(hc.userList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: getBullet(hc.userList[index]),
                    );
                  }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBullet(UserModel user) {
    return Stack(
      children: [
        CircleAvatar(
          radius: 26,
          backgroundImage: NetworkImage(user.imgUrl),
          backgroundColor: Colors.grey.shade300,
        ),
        if (user.isOnline) // Assuming `isOnline` is a property in `UserModel`
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 13,
              height: 13,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
            ),
          ),
      ],
    );
  }
}
