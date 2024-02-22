import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class CustomNavBar extends StatelessWidget {
  const CustomNavBar({
    super.key,
    required this.buttonText,
    required this.title,
    required this.onTap,
  });
  final String buttonText;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
        height: 60,
        elevation: 0,
        color: AppColor.signInBackColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            InkWell(
              onTap: onTap,
              child: Text(
                buttonText,
                style: const TextStyle(fontWeight: FontWeight.bold, color: AppColor.buttonColor),
              ),
            )
          ],
        ));
  }
}
