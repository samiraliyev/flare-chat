import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.iconData,
    this.inputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.isObscue = false,
    this.sufficIcon,
  });
  final TextEditingController controller;
  final String hintText;
  final IconData iconData;
  final TextInputAction? inputAction;
  final TextInputType? keyboardType;
  final bool? isObscue;
  final Widget? sufficIcon;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.fieldColor,
            boxShadow: const [BoxShadow(blurRadius: 200, color: AppColor.buttonColor)],

            borderRadius: const BorderRadius.all(Radius.circular(16)),
            border: Border.all(color: AppColor.buttonColor)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: TextField(
          
            obscureText: isObscue ?? false,
            keyboardType: keyboardType,
            textInputAction: inputAction,
            autocorrect: false,
            cursorColor: AppColor.buttonColor,
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              suffixIcon: sufficIcon,
              prefixIcon: Icon(iconData),
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 15),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
