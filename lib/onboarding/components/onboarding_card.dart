import 'package:flutter/material.dart';

import '../../utils/config/size_config.dart';
import 'onboarding_data.dart';

class OnboardingCard extends StatelessWidget {
  const OnboardingCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final OnboardingData data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        children: [
          Image.asset(
            data.image,
            height: SizeConfig2.blockV! * 35.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: (SizeConfig2.screenH! >= 850) ? 60 : 30),
          Text(
            data.title.toUpperCase(),
            textAlign: TextAlign.center,
            // style: TextStyle(
            //   fontWeight: FontWeight.w600,
            //   fontFamily: 'Mulish',
            //   fontSize: (SizeConfig2.screenW! >= 550) ? 35 : 30,
            // ),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Colors.black54,
                  fontSize: (SizeConfig2.screenW! >= 550) ? 35 : 30,
                ),
          ),
          const SizedBox(height: 15),
          Text(
            data.desc,
            // style: TextStyle(
            //   fontFamily: "Mulish",
            //   fontWeight: FontWeight.w300,
            //   fontSize: (SizeConfig2.screenW! >= 550) ? 25 : 17,
            // ),
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Colors.black45,
                  fontSize: (SizeConfig2.screenW! >= 550) ? 25 : 17,
                ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
