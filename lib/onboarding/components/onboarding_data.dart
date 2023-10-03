// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shopy/utils/constants/assets/images.dart';

@immutable
class OnboardingData {
  final String title;
  final String image;
  final String desc;
  const OnboardingData({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingData> onboardigns = [
  OnboardingData(
    title: "Track Your work and get the result",
    image: Images.onBorading1.path,
    desc: "Remember to keep track of your professional accomplishments.",
  ),
  OnboardingData(
    title: "Stay organized with team",
    image: Images.onBorading2.path,
    desc:
        "But understanding the contributions our colleagues make to our teams and companies.",
  ),
  OnboardingData(
    title: "Get notified when work happens",
    image: Images.onBorading3.path,
    desc:
        "Take control of notifications, collaborate live or on your own time.",
  ),
  OnboardingData(
    title: "Get notified when work happens",
    image: Images.onBorading4.path,
    desc:
        "Take control of notifications, collaborate live or on your own time.",
  ),
];
