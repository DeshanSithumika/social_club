import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  const TextFieldInput({
    super.key,
    required this.controller,
    this.isObscure = false,
    required this.hintText,
  });

  final TextEditingController controller;
  final bool isObscure;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(hintText: hintText,),
    );
  }
}
