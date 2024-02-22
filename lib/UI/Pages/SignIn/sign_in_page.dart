// ignore_for_file: must_be_immutable

import 'package:flare_chat_app/Bloc/SignIn/sign_in_cubit.dart';
import 'package:flare_chat_app/Components/Constants/colors.dart';
import 'package:flare_chat_app/Components/Constants/strings.dart';
import 'package:flare_chat_app/UI/Pages/Home/home_page.dart';
import 'package:flare_chat_app/Utility/Extension/svg_image_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../Components/Buttons/google_login_button.dart';
import '../../../Components/Buttons/register_button.dart';
import '../../../Components/Divider/or_divider.dart';
import '../../../Components/Input/custom_text_filed.dart';
import '../../../Components/Navbar/custom_navbar.dart';
import '../../Dialogs/failure_dialog.dart';
import '../SignUp/sign_up_page.dart';

@immutable
class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SignInStrings {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordContoller = TextEditingController();
  final GlobalKey key = GlobalKey();

  bool isVisiblePass = true;
  void changeVisible() {
    isVisiblePass = !isVisiblePass;
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavBar(
        buttonText: signUp,
        title: haveAccount,
        onTap: () => context.route.navigateToPage(const SignUpPage()),
      ),
      backgroundColor: AppColor.signInBackColor,
      body: BlocConsumer<SignInCubit, SignInState>(
        buildWhen: (_, current) => current is! SignInSuccess,
        listenWhen: (_, current) => current is SignInFailure || current is SignInSuccess,
        listener: (context, state) {
          if (state is SignInFailure) {
            showFailureDialog(context, state);
          } else if (state is SignInSuccess) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return const HomePage();
              },
            ));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 64,
                  ),
                  Center(child: SvgImagePath.signinlogo.toImage()),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    login,
                    style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    pleaseSignIn,
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(iconData: Icons.mail_outline, controller: _emailController, hintText: "Email"),
                  CustomTextField(
                      isObscue: isVisiblePass ? true : false,
                      sufficIcon: InkWell(
                        onTap: () {
                          changeVisible();
                        },
                        child: Icon(isVisiblePass ? Icons.visibility : Icons.visibility_off),
                      ),
                      inputAction: TextInputAction.done,
                      iconData: Icons.lock_outline,
                      controller: _passwordContoller,
                      hintText: "Password"),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: RegisterButton(
                        isProgress: (state is SignInProgress) ? true : false,
                        buttonText: loginButton,
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context
                              .read<SignInCubit>()
                              .signInWithEmail(email: _emailController.text, password: _passwordContoller.text);
                        }),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Center(
                      child: InkWell(
                          onTap: () {},
                          child: Text(
                            forgotPass,
                            style: const TextStyle(color: AppColor.buttonColor),
                          ))),
                  const SizedBox(
                    height: 16,
                  ),
                  const OrDivider(),
                  const SizedBox(
                    height: 16,
                  ),
                  GoogleLoginButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
