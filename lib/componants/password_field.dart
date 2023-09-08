import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    
    required this.controller,
    required this.onPressed,
    this.isObscure = true,

    super.key,
  });

  final TextEditingController controller;
  final bool isObscure;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: "Password",
        suffixIcon: IconButton(
            onPressed: onPressed,
            icon: isObscure
                ? const Icon(Icons.lock)
                : const Icon(Icons.lock_open)),
      ),
    );
  }
}
