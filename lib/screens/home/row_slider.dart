
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';

class HomeRowContainer extends StatelessWidget {
  String text;
  String activeTab;

  HomeRowContainer({super.key, required this.text, required this.activeTab});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        height: 40,
        decoration: BoxDecoration(
          color: activeTab == text ? AppColors.grey : AppColors.greyish,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppColors.purpleDark, width: 1.5)
        ),
        child: Center(child: Text(text, style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),)),
      ),
    );
  }
}

