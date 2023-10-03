// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shopy/onboarding/components/onboarding_data.dart';
import 'package:shopy/onboarding/components/skip_button.dart';
import 'package:shopy/utils/constants/constants.dart';
import 'package:shopy/utils/size_config.dart';

import 'components/dot.dart';
import 'components/onboarding_card.dart';
import 'components/onboarding_elevated_btn.dart';

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

  void _onPageChanged(int value) {
    setState(() => _currentPage = value);
    //_pageController.page!.toInt());
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
      //backgroundColor: colors[_currentPage],
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: kSecondaryGradientColor,
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                  itemCount: onboardigns.length,
                  physics: const BouncingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (value) => _onPageChanged(value),
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
                                SkipButton(
                                  onPressed: _skip,
                                ),
                                OnboardingElevatedButton(
                                  title: 'NEXT',
                                  isNext: true,
                                  onPressed: _next,
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
      ),
    );
  }

  void _skip() {
    _onPageChanged(onboardigns.length);
    _pageController.jumpToPage(onboardigns.length);
  }

  void _next() {
    setState(() => _currentPage++);
    _pageController.nextPage(
      duration: const Duration(microseconds: 200),
      curve: Curves.easeIn,
    );
  }
}
