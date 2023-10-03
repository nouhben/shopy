import 'package:flutter/material.dart';

import 'package:shopy/utils/constants/config/size_config.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        elevation: 0,
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: (SizeConfig2.screenW! <= 550) ? 13 : 17,
        ),
      ),
      child: const Text(
        "SKIP",
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
