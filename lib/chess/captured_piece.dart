// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shopy/chess/chess_piece.dart';

class CapturedPiece extends StatelessWidget {
  const CapturedPiece({
    Key? key,
    required this.piece,
  }) : super(key: key);
  final ChessPiece piece;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      piece.imagePath,
      color: piece.color,
    );
  }
}
