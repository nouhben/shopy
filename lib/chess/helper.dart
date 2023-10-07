import 'package:flutter/material.dart' show Colors;

import 'chess_piece.dart';

bool isSquareWhite(int index) {
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
  _initPawns(newBoard);
  //the rooks
  _initRooks(newBoard);
  // the knights
  _initKnights(newBoard);
  // the bishops
  _initBishops(newBoard);
  // the kings
  _initKings(newBoard);
  // the queens
  _initQueens(newBoard);
  return newBoard;
}

void _initQueens(List<List<ChessPiece?>> newBoard) {
  newBoard[0][3] = ChessPiece(
    type: ChessPieceType.queen,
    color: Colors.black,
    imagePath: ChessPieceType.queen.imagePath,
    isWhite: false,
  );
  newBoard[7][4] = ChessPiece(
    type: ChessPieceType.queen,
    color: Colors.white,
    imagePath: ChessPieceType.queen.imagePath,
    isWhite: true,
  );
}

void _initKings(List<List<ChessPiece?>> newBoard) {
  newBoard[0][4] = ChessPiece(
    type: ChessPieceType.king,
    color: Colors.black,
    imagePath: ChessPieceType.king.imagePath,
    isWhite: false,
  );
  newBoard[7][3] = ChessPiece(
    type: ChessPieceType.king,
    color: Colors.white,
    imagePath: ChessPieceType.king.imagePath,
    isWhite: true,
  );
}

void _initBishops(List<List<ChessPiece?>> newBoard) {
  newBoard[0][2] = ChessPiece(
    type: ChessPieceType.bishop,
    color: Colors.black,
    imagePath: ChessPieceType.bishop.imagePath,
    isWhite: false,
  );
  newBoard[0][5] = ChessPiece(
    type: ChessPieceType.bishop,
    color: Colors.black,
    imagePath: ChessPieceType.bishop.imagePath,
    isWhite: false,
  );
  newBoard[7][2] = ChessPiece(
    type: ChessPieceType.bishop,
    color: Colors.white,
    imagePath: ChessPieceType.bishop.imagePath,
    isWhite: true,
  );
  newBoard[7][5] = ChessPiece(
    type: ChessPieceType.bishop,
    color: Colors.white,
    imagePath: ChessPieceType.bishop.imagePath,
    isWhite: true,
  );
}

void _initKnights(List<List<ChessPiece?>> newBoard) {
  newBoard[0][1] = ChessPiece(
    type: ChessPieceType.knight,
    color: Colors.black,
    imagePath: ChessPieceType.knight.imagePath,
    isWhite: false,
  );
  newBoard[0][6] = ChessPiece(
    type: ChessPieceType.knight,
    color: Colors.black,
    imagePath: ChessPieceType.knight.imagePath,
    isWhite: false,
  );
  newBoard[7][1] = ChessPiece(
    type: ChessPieceType.knight,
    color: Colors.white,
    imagePath: ChessPieceType.knight.imagePath,
    isWhite: true,
  );
  newBoard[7][6] = ChessPiece(
    type: ChessPieceType.knight,
    color: Colors.white,
    imagePath: ChessPieceType.knight.imagePath,
    isWhite: true,
  );
}

void _initRooks(List<List<ChessPiece?>> newBoard) {
  newBoard[0][0] = ChessPiece(
    type: ChessPieceType.rook,
    color: Colors.black,
    imagePath: ChessPieceType.rook.imagePath,
    isWhite: false,
  );
  newBoard[0][7] = ChessPiece(
    type: ChessPieceType.rook,
    color: Colors.black,
    imagePath: ChessPieceType.rook.imagePath,
    isWhite: false,
  );
  newBoard[7][0] = ChessPiece(
    type: ChessPieceType.rook,
    color: Colors.white,
    imagePath: ChessPieceType.rook.imagePath,
    isWhite: true,
  );
  newBoard[7][7] = ChessPiece(
    type: ChessPieceType.rook,
    color: Colors.white,
    imagePath: ChessPieceType.rook.imagePath,
    isWhite: true,
  );
}

void _initPawns(List<List<ChessPiece?>> newBoard) {
  for (int i = 0; i < 8; i++) {
    newBoard[1][i] = ChessPiece(
      type: ChessPieceType.pawne,
      color: Colors.black,
      imagePath: ChessPieceType.pawne.imagePath,
      isWhite: false,
    );
    newBoard[6][i] = ChessPiece(
      type: ChessPieceType.pawne,
      color: Colors.white,
      imagePath: ChessPieceType.pawne.imagePath,
      isWhite: true,
    );
  }
}

isInBoard(int row, int col) => row >= 0 && col >= 0 && row < 8 && col < 8;
