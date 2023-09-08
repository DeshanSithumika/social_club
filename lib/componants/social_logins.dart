import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLogins extends StatelessWidget {
  const SocialLogins({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
            onTap: () {
              //====google sign in function here
            },
            child: SvgPicture.asset("assets/Google.svg")),
        const SizedBox(width: 32),
        InkWell(
            onTap: () {
              //=====facebook sign in function here
            },
            child: SvgPicture.asset("assets/Facebook.svg")),
      ],
    );
  }
}
