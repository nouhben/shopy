// ignore_for_file: public_member_api_docs, sort_constructors_first
class OnboardingData {
  final String title;
  final String image;
  final String desc;
  OnboardingData({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingData> onboardigns = [
  OnboardingData(
    title: "Track Your work and get the result",
    image: "assets/images/image1.png",
    desc: "Remember to keep track of your professional accomplishments.",
  ),
  OnboardingData(
    title: "Stay organized with team",
    image: "assets/images/image2.png",
    desc:
        "But understanding the contributions our colleagues make to our teams and companies.",
  ),
  OnboardingData(
    title: "Get notified when work happens",
    image: "assets/images/image3.png",
    desc:
        "Take control of notifications, collaborate live or on your own time.",
  ),
];
