import 'package:chat_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class HeaderDivider extends StatelessWidget {
  final String text;
  final int? count;

  const HeaderDivider({
    super.key,
    required this.text,
    this.count,
  });

  @override
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            count != null ? '$text ($count)' : text,
            style: TextStyle(
              color: AppColors.purpleDark,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 20),
          const Expanded(
            child: Divider(
              color: Colors.grey,
              thickness: 1.1,
            ),
          ),
        ],
      ),
    );
  }


}
