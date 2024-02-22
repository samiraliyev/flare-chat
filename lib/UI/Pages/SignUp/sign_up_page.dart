// ignore_for_file: must_be_immutable

import 'package:flare_chat_app/Bloc/SignUp/sign_up_cubit.dart';
import 'package:flare_chat_app/Components/Input/custom_text_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

import '../../../Components/Buttons/register_button.dart';
import '../../../Components/Constants/colors.dart';
import '../../../Components/Constants/strings.dart';
import '../../Dialogs/failure_dialog.dart';
import '../Home/home_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignUpStrings {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();

  bool isVisiblePass = true;
  void changeVisible() {
    isVisiblePass = !isVisiblePass;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      buildWhen: (_, current) => current is! SignUpSuccess,
      listenWhen: (_, current) => current is SignUpFailure || current is SignUpSuccess,
      listener: (context, state) {
        if (state is SignUpFailure) {
          return showFailureDialog(context, state);
        } else if (state is SignUpSuccess) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ));
        }
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: AppColor.signInBackColor,
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 24.0, right: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    InkWell(
                        onTap: () => context.route.pop(),
                        child: const Icon(
                          Icons.arrow_back_sharp,
                          size: 35,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      createAccount,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      pleaseFill,
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await context.read<SignUpCubit>().pickAndCheckImage();
                          setState(() {});
                        },
                        child: Container(
                          decoration:
                              BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColor.buttonColor)),
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 50,
                            child: context.watch<SignUpCubit>().selectedFileBytes != null
                                ? ClipOval(
                                    child: Image.memory(
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      context.watch<SignUpCubit>().selectedFileBytes!,
                                    ),
                                  )
                                : const Icon(Icons.add_a_photo_outlined),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomTextField(
                        controller: _usernameController, hintText: "Username", iconData: Icons.person_outline),
                    CustomTextField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        hintText: "Phone",
                        iconData: Icons.phone_iphone_rounded),
                    CustomTextField(controller: _emailController, hintText: "Email", iconData: Icons.mail_outline),
                    CustomTextField(
                        isObscue: isVisiblePass ? true : false,
                        sufficIcon: InkWell(
                          onTap: () {
                            changeVisible();
                          },
                          child: Icon(isVisiblePass ? Icons.visibility : Icons.visibility_off),
                        ),
                        controller: _passwordController,
                        hintText: "Password",
                        iconData: Icons.lock_outline),
                    CustomTextField(
                        isObscue: isVisiblePass ? true : false,
                        sufficIcon: InkWell(
                          onTap: () {
                            changeVisible();
                          },
                          child: Icon(isVisiblePass ? Icons.visibility : Icons.visibility_off),
                        ),
                        inputAction: TextInputAction.done,
                        controller: _repasswordController,
                        hintText: "Confirm Password",
                        iconData: Icons.lock_outline),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: RegisterButton(
                          isProgress: (state is SignUpProgress) ? true : false,
                          buttonText: signUpButton,
                          onTap: (_usernameController.text.trim().isNotEmpty &&
                                  _passwordController.text.trim().isNotEmpty &&
                                  _emailController.text.trim().isNotEmpty &&
                                  _phoneController.text.trim().isNotEmpty &&
                                  _repasswordController.text.trim().isNotEmpty)
                              ? () {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  context.read<SignUpCubit>().signUpWithEmail(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      repassword: _repasswordController.text,
                                      phone: _phoneController.text,
                                      username: _usernameController.text);
                                }
                              : null),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
