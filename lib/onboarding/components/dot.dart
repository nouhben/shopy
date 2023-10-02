import 'package:flutter/material.dart';

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
