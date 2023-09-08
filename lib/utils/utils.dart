import 'package:flutter/material.dart';

class NavigateFunctions {
  //===navigate widget
  static void navigateTo(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget,
        ));
  }

  //navigator pop function
  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}
