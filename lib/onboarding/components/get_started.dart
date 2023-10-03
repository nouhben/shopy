import 'package:flutter/material.dart';
import 'package:shopy/onboarding/components/onboarding_data.dart';

import '../../utils/strings.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(36),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(onboardigns.last.image),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 36.0),
              Text(
                CustomStrings.make.text,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 16.0),
              Text(
                CustomStrings.home.text,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
