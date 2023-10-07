// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shopy/chess/chess_piece.dart';
import 'package:shopy/chess/colors.dart';

class Square extends StatelessWidget {
  const Square({
    Key? key,
    required this.isWhite,
    required this.onTap,
    this.piece,
    this.isSelected = false,
    required this.isValidMove,
  }) : super(key: key);
  final bool isWhite;
  final bool isValidMove;
  final bool isSelected;
  final ChessPiece? piece;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Color? squarColor = isWhite ? forgroundColor : backgroundColor;
    if (isSelected) {
      squarColor = selectedSquarColor;
    }
    /**
     *   if (isSelected) {
      squarColor = selectedSquarColor;
    } else if (isValidMove) {
      squarColor = validMoveColor;
    } else {
      squarColor = isWhite ? forgroundColor : backgroundColor;
    }
     */
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            color: squarColor,
            padding: const EdgeInsets.all(8.0),
            child: piece != null
                ? Center(
                    child: Image.asset(
                      piece!.imagePath,
                      color: piece!.color,
                    ),
                  )
                : null,
          ),
          if (isValidMove) const Center(child: ValidMoveDot()),
        ],
      ),
    );
  }
}

class ValidMoveDot extends StatelessWidget {
  const ValidMoveDot({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 24.0,
      height: 24.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: validMoveColor,
      ),
    );
  }
}
