import 'package:flutter/material.dart';

class ChatNotFound extends StatelessWidget {
  const ChatNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Chat not found!', style: TextStyle(fontSize: 30),)),
    );
  }
}
