import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_club/componants/custom_button.dart';
import 'package:social_club/componants/password_field.dart';
import 'package:social_club/componants/social_logins.dart';
import 'package:social_club/componants/text_field_input.dart';
import 'package:social_club/resources/auth_methods.dart';
import 'package:social_club/screens/password_reset_screen.dart';
import 'package:social_club/screens/signup_screen.dart';
import 'package:social_club/utils/black_text.dart';
import 'package:social_club/utils/colors.dart';
import 'package:social_club/utils/custom_text.dart';
import 'package:social_club/utils/normal_text.dart';
import 'package:social_club/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

bool isObscure = true;

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool isLoading = false;

//===user login function
  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    //======loging navigation here
    String res = await AuthMethods().signInUser(
        emailAddress: _email.text, password: _password.text, context: context);

    if (res == "success") {
      //
      NavigateFunctions.navigateTo(
        context,
        ResponsiveLayout(
            webScreenLayout: const WebScreenLayout(),
            mobileScreenLayout: const MobileScreenLayout()),
      );
    }
    //

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
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
                      text: "LOGIN",
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
                          const BlackText(text: "Welcome back"),
                          const SizedBox(height: 12),
                          const NormalText(text: "Sign in with your account"),
                          const SizedBox(height: 37),
                          const NormalText(text: "Username"),
                          TextFieldInput(
                              controller: _email, hintText: "Enter email here"),
                          const SizedBox(height: 20),
                          const NormalText(text: "Password"),
                          PasswordField(
                            controller: _password,
                            isObscure: isObscure,
                            onPressed: () {
                              setState(() {
                                isObscure = !isObscure;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: CustomButton(
                                onTap: loginUser,
                                isLoading: isLoading,
                                text: "LOGIN"),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const NormalText(text: "Forgot your password?"),
                              InkWell(
                                onTap: () {
                                  ///-----navigate reset page here
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const PasswordResetPage(),
                                      ));
                                },
                                child: const NormalText(
                                  text: "Reset here",
                                  color: blueColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SignUpScreen(),
                                    ));
                              },
                              child: const Center(
                                  child: NormalText(
                                text: "Create an Account",
                                color: blueColor,
                                fontWeight: FontWeight.w700,
                              ))),
                          const SizedBox(height: 20),
                          const Center(
                              child: NormalText(text: "OR SIGN IN WITH")),
                          const SizedBox(height: 15),
                          const SocialLogins(),
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
