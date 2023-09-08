import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_club/componants/custom_button.dart';
import 'package:social_club/componants/password_field.dart';
import 'package:social_club/componants/social_logins.dart';
import 'package:social_club/componants/text_field_input.dart';
import 'package:social_club/resources/auth_methods.dart';
import 'package:social_club/screens/login_screen.dart';
import 'package:social_club/utils/black_text.dart';
import 'package:social_club/utils/colors.dart';
import 'package:social_club/utils/custom_text.dart';
import 'package:social_club/utils/image_picker.dart';
import 'package:social_club/utils/normal_text.dart';
import 'package:social_club/utils/utils.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout.dart';
import '../responsive/web_screen_layout.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _bio = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  void selectImage() async {
    Uint8List? im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _email.text,
        password: _password.text,
        username: _username.text,
        bio: _bio.text,
        file: _image,
        context: context);

    if (res != "success") {
      //
      NavigateFunctions.navigateTo(
        context,
        ResponsiveLayout(
            webScreenLayout: const WebScreenLayout(),
            mobileScreenLayout: const MobileScreenLayout()),
      );
    }

    setState(() {
      _isLoading = false;
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
          const SizedBox(height: 30),
          SvgPicture.asset(
            'assets/LOGO.svg',
            width: 110,
            height: 56,
          ),
          const SizedBox(height: 25),
          SizedBox(
            width: size.width,
            height: 920,
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
                      text: "SIGN UP",
                    ),
                  ),
                ),
                Positioned(
                  top: 64,
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    width: size.width,
                    height: 900,
                    decoration: const BoxDecoration(
                        color: mobileSearchColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const BlackText(text: "Welcome to Club"),
                        const SizedBox(height: 12),
                        const NormalText(text: "Create new account"),
                        const SizedBox(height: 30),

                        //===========circular widget to accept and show our selected file

                        Stack(children: [
                          Center(
                            child: _image != null
                                ? CircleAvatar(
                                    radius: 64,
                                    backgroundImage: MemoryImage(_image!))
                                : const CircleAvatar(
                                    radius: 64,
                                    backgroundImage: NetworkImage(
                                        "https://plus.unsplash.com/premium_photo-1681140029733-7f2fd24c2437?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1475&q=80"),
                                  ),
                          ),
                          Positioned(
                              bottom: -10,
                              right: 120,
                              child: IconButton(
                                icon: const Icon(Icons.add_a_photo),
                                onPressed: () {
                                  //=======select photo here

                                  selectImage();
                                },
                              )),
                        ]),
                        const SizedBox(height: 20),

                        const NormalText(text: "Username"),
                        TextFieldInput(
                            controller: _username,
                            hintText: "Enter your username here "),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        const NormalText(text: "Email"),
                        TextFieldInput(
                            controller: _email, hintText: "Enter email here"),
                        const SizedBox(height: 20),
                        const NormalText(text: "Bio"),
                        TextFieldInput(
                            controller: _bio, hintText: "Enter your bio here"),
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
                              // ====signup function
                              onTap: signUpUser,
                              text: "SIGN UP",
                              isLoading: _isLoading),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const NormalText(text: "Already have an Account?"),
                            InkWell(
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ));

                                ///-----navigate reset page here
                              },
                              child: const NormalText(
                                text: "Login here",
                                color: blueColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Center(
                            child: NormalText(text: "OR SIGN IN WITH")),
                        const SizedBox(height: 15),
                        const SocialLogins(),
                      ],
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
