import 'package:flutter/material.dart';
import 'package:shopy/utils/size_config.dart';

class OnboardingElevatedButton extends StatelessWidget {
  const OnboardingElevatedButton({
    Key? key,
    required this.title,
    required this.onPressed,
    this.isNext = false,
  }) : super(key: key);
  final String title;
  final VoidCallback onPressed;
  final bool isNext;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          padding: (SizeConfig2.screenW! <= 550)
              ? EdgeInsets.symmetric(
                  horizontal: isNext ? 30 : 100,
                  vertical: 20,
                )
              : EdgeInsets.symmetric(
                  horizontal: isNext ? 30 : SizeConfig2.screenW! * 0.2,
                  vertical: 25,
                ),
          textStyle: TextStyle(
            fontSize: (SizeConfig2.screenW! <= 550) ? 13 : 17,
          ),
        ),
        child: Text(title),
      ),
    );
  }
}
