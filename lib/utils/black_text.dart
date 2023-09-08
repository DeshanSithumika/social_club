import 'dart:ui';

import 'package:flutter/material.dart';

class BlackText extends StatelessWidget {
  const BlackText({
    required this.text,
    this.fontsize = 24,
    super.key,
  });

  final String text;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: fontsize, fontWeight: FontWeight.w800, color: Colors.grey),
    );
  }
}
