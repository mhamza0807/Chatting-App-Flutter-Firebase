import 'package:chat_app/screens/auth/login_screen.dart';
import 'package:chat_app/screens/call/audio_call.dart';
import 'package:chat_app/screens/call/video_call.dart';
import 'package:chat_app/screens/home/home_screen.dart';
import 'package:chat_app/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/auth/signup_screen.dart';
import '../screens/chat/chat_screen.dart';

class AppRoutes {
  static appRoutes() => [
    GetPage(name: '/', page: () => SplashScreen()),
    GetPage(name: '/login_screen', page: () => LoginScreen()),
    GetPage(name: '/signup_screen', page: () => SignupScreen()),
    GetPage(name: '/home_screen', page: () => HomeScreen(),transition: Transition.rightToLeftWithFade),
    GetPage(name: '/chat_screen', page: () => ChatScreen(),transition: Transition.rightToLeftWithFade),
    GetPage(name: '/audio_call', page: () => AudioCall(),transition: Transition.downToUp),
    GetPage(name: '/video_call', page: () => VideoCall(),transition: Transition.downToUp),
  ];
}
