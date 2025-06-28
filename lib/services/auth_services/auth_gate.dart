import 'dart:async';
import 'package:chat_app/utils/app_colors.dart';
import 'package:chat_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class AuthGate {
  final FirebaseAuth auth = FirebaseAuth.instance;

  void isLogin() {
    Timer(const Duration(seconds: 2), () {
      final user = auth.currentUser;

      if (user != null) {
        Get.offNamed('/home_screen');
      } else {
        Get.offNamed('/login_screen');
      }
    });
  }

  Future<void> signUp(String email, String pw, String name, String url) async {
    try {
      UserCredential cred = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );

      final uid = cred.user!.uid;

      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'uid': uid,
        'name': name,
        'email': email,
        'imgUrl': url,
        'isOnline': true,
        'lastSeen': DateTime.now(),
        'friends': []
      });

      Utils.toastMessage(
        message: 'Logged in as $email',
        color: AppColors.darkGreen,
      );
      Get.offNamed('/home_screen');
    } catch (e) {
      Utils.toastMessage(message: e.toString());
    }
  }


  Future<void> login(String email, String pw) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pw);
      Utils.toastMessage(
        message: 'Logged in as $email',
        color: AppColors.darkGreen,
      );
      Get.offNamed('/home_screen');
    } catch (e) {
      Utils.toastMessage(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
      Utils.toastMessage(message: 'Logged out', color: AppColors.darkGreen);
      Get.offNamed('/login_screen');
    } catch (e) {
      Utils.toastMessage(message: e.toString());
    }
  }
}
