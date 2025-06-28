import 'package:chat_app/controllers/auth/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  const AuthButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Obx(() => ElevatedButton(
      onPressed: authController.isLoading.value ? null : () => onPressed(),
      style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(50)),
      child: authController.isLoading.value
          ? const CircularProgressIndicator(color: Colors.white)
          : Text(text, style: const TextStyle(fontSize: 16)),
    ));
  }
}