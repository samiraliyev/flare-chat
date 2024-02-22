import 'package:flare_chat_app/UI/Pages/Home/home_page.dart';
import 'package:flare_chat_app/UI/Pages/SignIn/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../Bloc/Authentication/auth_cubit.dart';
import '../../../Components/Constants/colors.dart';
import '../../../Components/Constants/paths.dart';
import '../../../Components/Constants/strings.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state == AuthState.initial) {
          return Scaffold(
            backgroundColor: AppColor.backColor,
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(Paths.splashLottie, height: 100),
                const Text(
                  AppStrings.loading,
                  style: TextStyle(fontSize: 18),
                )
              ],
            )),
          );
        } else if (state == AuthState.authentication) {
          return const HomePage();
        }
        return const SignInPage();
      },
    );
  }
}
