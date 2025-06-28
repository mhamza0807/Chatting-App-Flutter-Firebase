import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Utils {
  static toastMessage({required String message, Color color = Colors.red}) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      fontSize: 18,
      msg: message,
      backgroundColor: color,
      gravity: ToastGravity.BOTTOM,
    );
  }

  static void snackBar(
    String title,
    String message, [
    Color color = Colors.black87,
  ]) {
    Get.snackbar(
      title,
      message,
      backgroundColor: color,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      isDismissible: true
    );
  }
}
