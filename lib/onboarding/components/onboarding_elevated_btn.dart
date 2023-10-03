import 'package:flutter/material.dart';

import '../../utils/config/size_config.dart';

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
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeIn,
        width: !isNext ? SizeConfig2.screenW! * .8 : SizeConfig2.screenW! * 0.4,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 2,
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            padding: (SizeConfig2.screenW! <= 550)
                ? EdgeInsets.symmetric(
                    horizontal: isNext ? 30 : 100,
                    vertical: 8.0,
                  )
                : EdgeInsets.symmetric(
                    horizontal: isNext ? 30 : SizeConfig2.screenW! * 0.2,
                    vertical: 25,
                  ),
            textStyle: TextStyle(
              fontSize: (SizeConfig2.screenW! <= 550) ? 13 : 17,
              color: Colors.white,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 8.0),
              // SvgPicture.asset(
              //   CustomIcons.rightLongArrow.path,
              //   width: (SizeConfig2.screenW! <= 400) ? 36 : 48.0,
              //   color: Colors.white,
              // ),
              const Icon(
                Icons.arrow_forward_ios_sharp,
                color: Colors.white,
                size: 36.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
