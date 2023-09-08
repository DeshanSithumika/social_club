import 'package:flutter/material.dart';
import 'package:social_club/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.text,
    this.isLoading = false,
    required this.onTap,
    super.key,
  });

  final String text;
  final bool isLoading;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 295,
        height: 60,
        decoration: const BoxDecoration(
            color: blueColor,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator.adaptive(
                  backgroundColor: Colors.white,
                )
              : Text(text,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: primaryColor)),
        ),
      ),
    );
  }
}
