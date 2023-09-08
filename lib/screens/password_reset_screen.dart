import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_club/componants/custom_button.dart';
import 'package:social_club/componants/text_field_input.dart';
import 'package:social_club/screens/login_screen.dart';
import 'package:social_club/utils/black_text.dart';
import 'package:social_club/utils/colors.dart';
import 'package:social_club/utils/custom_text.dart';
import 'package:social_club/utils/normal_text.dart';
import 'package:social_club/utils/utils.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({super.key});

  @override
  State<PasswordResetPage> createState() => _PasswordResetPageState();
}

bool isObscure = true;

class _PasswordResetPageState extends State<PasswordResetPage> {
  final TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          SvgPicture.asset(
            'assets/LOGO.svg',
            width: 110,
            height: 56,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: size.width,
            height: 630,
            child: Stack(
              children: [
                Container(
                  width: size.width,
                  height: 80,
                  decoration: const BoxDecoration(
                      color: blueColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(28),
                          topRight: Radius.circular(28))),
                  child: const Center(
                    child: CustomText(
                      text: "RESET PASSWORD",
                    ),
                  ),
                ),
                Positioned(
                  top: 64,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: size.width,
                    height: 575,
                    decoration: const BoxDecoration(
                        color: mobileSearchColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const BlackText(text: "Reset Faction"),
                          const SizedBox(height: 12),
                          const NormalText(text: "Reset your password "),
                          const SizedBox(height: 37),
                          const NormalText(text: "User email"),
                          TextFieldInput(
                              controller: _email, hintText: "Enter email here"),
                          const SizedBox(height: 20),
                          Center(
                            child: CustomButton(
                                onTap: () async {
                                  // password reset function here
                                  await FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: _email.text);
                                },
                                text: "RESET"),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const NormalText(text: "Back to Login."),
                              InkWell(
                                onTap: () {
                                  ///-----navigate reset page here
                                  NavigateFunctions.navigateTo(
                                      context, const LoginScreen());
                                },
                                child: const NormalText(
                                  text: "Click here",
                                  color: blueColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}
