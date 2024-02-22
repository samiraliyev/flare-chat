// ignore_for_file: must_be_immutable

import 'package:flare_chat_app/Components/Constants/colors.dart';
import 'package:flare_chat_app/Components/Constants/strings.dart';
import 'package:flare_chat_app/Utility/Extension/svg_image_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/SignIn/sign_in_cubit.dart';

@immutable
class GoogleLoginButton extends StatelessWidget with SignInStrings {
  GoogleLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        context.read<SignInCubit>().signInWithGoogle();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.signInBackColor,
          boxShadow: const [BoxShadow(blurRadius: 10, color: AppColor.buttonColor)],

          border: Border.all(color: AppColor.buttonColor),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              SvgImagePath.googleicon.toIcon(),
              const SizedBox(
                width: 12,
              ),
              Text(
                googleLogin,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
