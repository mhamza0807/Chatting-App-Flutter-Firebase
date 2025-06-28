import 'package:flutter/material.dart';

class TitleContainer extends StatelessWidget {
  const TitleContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(30),
        ),
      ),
    );
  }
}
