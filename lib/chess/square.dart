// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shopy/chess/chess_piece.dart';
import 'package:shopy/chess/colors.dart';

class Square extends StatelessWidget {
  final bool isWhite;
  final bool isSelected;
  final ChessPiece? piece;
  final void Function()? onTap;
  const Square({
    Key? key,
    required this.isWhite,
    required this.onTap,
    this.piece,
    this.isSelected = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: isSelected
            ? selectedSquarColor
            : isWhite
                ? forgroundColor
                : backgroundColor,
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
        child: piece != null
            ? Image.asset(
                piece!.imagePath,
                color: piece!.color,
                fit: BoxFit.contain,
              )
            : null,
      ),
    );
  }
}
