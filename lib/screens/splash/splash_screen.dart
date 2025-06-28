import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/services/auth_services/auth_gate.dart';
import 'package:chat_app/utils/app_colors.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final authService = AuthGate();

  @override
  void initState() {
    super.initState();
    authService.isLogin();
  }

  @override
  Widget build(BuildContext context) {

    final size = Get.size;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(child: Text('Flutter Chat App', style: TextStyle(fontSize: 22),))

    );
  }
}
