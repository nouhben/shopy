// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shopy/onboarding/components/onboarding_data.dart';
import 'package:shopy/utils/size_config.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int _currentPage = 0;
  final List<Color> colors = const [
    Color(0xffDAD3C8),
    Color(0xffFFE5DE),
    Color(0xffDCF6E6),
  ];
  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig2.init(context);
    return Scaffold(
      backgroundColor: colors[_currentPage],
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: PageView.builder(
                itemCount: onboardigns.length,
                physics: const BouncingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemBuilder: (context, index) => OnboardingCard(
                  data: onboardigns[index],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardigns.length,
                      (index) => Dot(isActive: index == _currentPage),
                    ),
                  ),
                  _currentPage + 1 == onboardigns.length
                      ? OnboardingElevatedButton(
                          title: 'START',
                          onPressed: () {},
                        )
                      : Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  _pageController.jumpToPage(2);
                                  setState(
                                      () => _currentPage = onboardigns.length);
                                },
                                style: TextButton.styleFrom(
                                  elevation: 0,
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize:
                                        (SizeConfig2.screenW! <= 550) ? 13 : 17,
                                  ),
                                ),
                                child: const Text(
                                  "SKIP",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              OnboardingElevatedButton(
                                title: 'NEXT',
                                isNext: true,
                                onPressed: () {
                                  setState(() => _currentPage++);
                                  _pageController.nextPage(
                                    duration: const Duration(microseconds: 200),
                                    curve: Curves.easeIn,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          ),
          SizedBox(height: (SizeConfig2.screenH! >= 850) ? 60 : 30),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontFamily: 'Mulish',
              fontSize: (SizeConfig2.screenW! >= 550) ? 35 : 30,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            data.desc,
            style: TextStyle(
              fontFamily: "Mulish",
              fontWeight: FontWeight.w300,
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

class Dot extends StatelessWidget {
  const Dot({super.key, required this.isActive});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeIn,
      height: 10.0,
      width: isActive ? 20.0 : 10.0,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(50.0),
        ),
        color: Color(0xFF000000),
      ),
      margin: const EdgeInsets.only(right: 5.0),
    );
  }
}
