import 'package:flutter/material.dart';
import 'package:shopy/onboarding/onboarding_screen.dart';

import 'chess/chess_board.dart';
import 'utils/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Shop App',
      theme: AppThemeData.lightThemeData,
      home: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 5)),
        builder: (context, snapshot) => const ChessBoard(),
      ), //const OnboardingScreen(),
    );
  }
}
