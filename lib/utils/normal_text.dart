import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  const NormalText({
    required this.text,
    this.fontsize = 14,
    this.color = Colors.grey,
    this.fontWeight = FontWeight.w400,
    super.key,
  });

  final String text;
  final double fontsize;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style:
          TextStyle(fontSize: fontsize, fontWeight: fontWeight, color: color),
    );
  }
}
