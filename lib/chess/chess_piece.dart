import 'package:flutter/material.dart' show Color;

enum ChessPieceType {
  pawne('lib/chess/icons/pawn.png'),
  rook('lib/chess/icons/rook.png'),
  bishop('lib/chess/icons/bishop.png'),
  king('lib/chess/icons/king.png'),
  queen('lib/chess/icons/queen.png'),
  knight('lib/chess/icons/knight.png');

  const ChessPieceType(this.imagePath);
  final String imagePath;
}

enum Direction { up, down }

class ChessPiece {
  final ChessPieceType type;
  final Color color;
  final String imagePath;
  final bool isWhite;
  ChessPiece({
    required this.type,
    required this.color,
    required this.imagePath,
    required this.isWhite,
  });
}
