import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.isProgress,
  });

  final String buttonText;
  final VoidCallback? onTap;
  final bool isProgress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: const [BoxShadow(blurRadius: 10, color: AppColor.buttonColor)],
          color: isProgress ? AppColor.signInBackColor : AppColor.buttonColor,
          border: Border.all(color: isProgress ? AppColor.buttonColor : Colors.transparent),
          borderRadius: const BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
              child: isProgress
                  ? const CircularProgressIndicator(
                      color: AppColor.buttonColor,
                    )
                  : Text(
                      buttonText,
                      style:
                          const TextStyle(color: AppColor.signInBackColor, fontSize: 20, fontWeight: FontWeight.w600),
                    )),
        ),
      ),
    );
  }
}
