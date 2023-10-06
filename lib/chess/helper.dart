import 'package:flutter/material.dart' show Colors;

import 'chess_piece.dart';

bool isWhite(int index) {
  int row = index ~/ 8;
  int column = index % 8;

  return (row + column) % 2 == 0;
}

List<List<ChessPiece?>> initBorad() {
  List<List<ChessPiece?>> newBoard = List.generate(
    8,
    (row) => List.generate(
      8,
      (column) => null,
    ),
  );
  // the pawns
  for (int i = 0; i < 8; i++) {
    newBoard[1][i] = ChessPiece(
      type: ChessPieceType.pawne,
      color: Colors.black,
      imagePath: ChessPieceType.pawne.imagePath,
    );
    newBoard[6][i] = ChessPiece(
      type: ChessPieceType.pawne,
      color: Colors.white,
      imagePath: ChessPieceType.pawne.imagePath,
    );
  }
  //the rooks
  newBoard[0][0] = ChessPiece(
    type: ChessPieceType.rook,
    color: Colors.black,
    imagePath: ChessPieceType.rook.imagePath,
  );
  newBoard[0][7] = ChessPiece(
    type: ChessPieceType.rook,
    color: Colors.black,
    imagePath: ChessPieceType.rook.imagePath,
  );
  newBoard[7][0] = ChessPiece(
    type: ChessPieceType.rook,
    color: Colors.white,
    imagePath: ChessPieceType.rook.imagePath,
  );
  newBoard[7][7] = ChessPiece(
    type: ChessPieceType.rook,
    color: Colors.white,
    imagePath: ChessPieceType.rook.imagePath,
  );
  // the knights
  newBoard[0][1] = ChessPiece(
    type: ChessPieceType.knight,
    color: Colors.black,
    imagePath: ChessPieceType.knight.imagePath,
  );
  newBoard[0][6] = ChessPiece(
    type: ChessPieceType.knight,
    color: Colors.black,
    imagePath: ChessPieceType.knight.imagePath,
  );
  newBoard[7][1] = ChessPiece(
    type: ChessPieceType.knight,
    color: Colors.white,
    imagePath: ChessPieceType.knight.imagePath,
  );
  newBoard[7][6] = ChessPiece(
    type: ChessPieceType.knight,
    color: Colors.white,
    imagePath: ChessPieceType.knight.imagePath,
  );
  // the bishops
  newBoard[0][2] = ChessPiece(
    type: ChessPieceType.bishop,
    color: Colors.black,
    imagePath: ChessPieceType.bishop.imagePath,
  );
  newBoard[0][5] = ChessPiece(
    type: ChessPieceType.bishop,
    color: Colors.black,
    imagePath: ChessPieceType.bishop.imagePath,
  );
  newBoard[7][2] = ChessPiece(
    type: ChessPieceType.bishop,
    color: Colors.white,
    imagePath: ChessPieceType.bishop.imagePath,
  );
  newBoard[7][5] = ChessPiece(
    type: ChessPieceType.bishop,
    color: Colors.white,
    imagePath: ChessPieceType.bishop.imagePath,
  );
  // the kings
  newBoard[0][4] = ChessPiece(
    type: ChessPieceType.king,
    color: Colors.black,
    imagePath: ChessPieceType.king.imagePath,
  );
  newBoard[7][3] = ChessPiece(
    type: ChessPieceType.king,
    color: Colors.white,
    imagePath: ChessPieceType.king.imagePath,
  );
  // the queens
  newBoard[0][3] = ChessPiece(
    type: ChessPieceType.queen,
    color: Colors.black,
    imagePath: ChessPieceType.queen.imagePath,
  );
  newBoard[7][4] = ChessPiece(
    type: ChessPieceType.queen,
    color: Colors.white,
    imagePath: ChessPieceType.queen.imagePath,
  );
  return newBoard;
}

isInBoard(int row, int col) => row >= 0 && col >= 0 && row < 8 && col < 8;