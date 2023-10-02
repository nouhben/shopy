import 'package:flutter/material.dart'
    show MediaQuery, MediaQueryData, Orientation, BuildContext;

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late Orientation orientation;

  // ignore: unused_element
  void _init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData.size.height;
    screenWidth = _mediaQueryData.size.width;
    orientation = _mediaQueryData.orientation;
  }
}

class SizeConfig2 {
  static MediaQueryData? _mediaQueryData;
  static double? screenW;
  static double? screenH;
  static double? blockH;
  static double? blockV;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenW = _mediaQueryData!.size.width;
    screenH = _mediaQueryData!.size.height;
    blockH = screenW! / 100;
    blockV = screenH! / 100;
  }
}

double getProportionatScreenHeight({required double inputHeight}) =>
    SizeConfig.screenHeight * (inputHeight / 812.0);
double getProportionatScreenWidth({required double inputWidth}) =>
    SizeConfig.screenWidth * (inputWidth / 375.0);
