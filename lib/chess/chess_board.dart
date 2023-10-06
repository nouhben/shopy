// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shopy/chess/chess_piece.dart';

import 'package:shopy/chess/square.dart';

import 'helper.dart';

class ChessBoard extends StatefulWidget {
  const ChessBoard({super.key});

  @override
  State<ChessBoard> createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  late List<List<ChessPiece?>> _board;

  ChessPiece? _selectedPiece;
  int _selectedRow = -1;
  int _selectedColumn = -1;

  @override
  void initState() {
    super.initState();
    _board = initBorad();
  }

  void _selectPiece(int row, int col) {
    if (_board[row][col] != null) {
      if (_selectedPiece != _board[row][col]) {
        setState(() {
          _selectedPiece = _board[row][col];
          _selectedRow = row;
          _selectedColumn = col;
        });
      } else {
        setState(() {
          _selectedPiece = null;
          _selectedRow = -1;
          _selectedColumn = -1;
        });
      }
      _validMoves = _calculateRawValidMoves(
        _selectedRow,
        _selectedColumn,
        _selectedPiece,
      );
    }
  }

  List<List<int>> _validMoves = [];
  List<List<int>> _calculateRawValidMoves(
    int row,
    int col,
    ChessPiece? selctedPiece,
  ) {
    List<List<int>> candidateMoves = [];
    //Direction direction =
    //selctedPiece!.color == Colors.white ? Direction.up : Direction.down;
    // we can use -1 one for up and 1 for down

    int direction = selctedPiece!.color == Colors.white ? -1 : 1;
    bool _isWhite = direction == -1;

    switch (selctedPiece.type) {
      case ChessPieceType.pawne:
        {
          // PAWns can move one square forward
          if (isInBoard(row + direction, col) &&
              _board[row + direction][col] == null) {
            candidateMoves.add([row + direction, col]);
          }
          // pawns can move 2 square forward if they are at initial position 6th row for black and 2nd row for whites
          if ((row == 6 && direction == -1) || (row == 1 && direction == 1)) {
            if (isInBoard(row + 2 * direction, col) &&
                _board[row + direction][col] == null &&
                _board[row + 2 * direction][col] == null) {
              candidateMoves.add([row + 2 * direction, col]);
            }
          }
          // PAWNS can kill diagonally and take the space
          if (isInBoard(row + direction, col + 1) &&
              (_board[row + direction][col + 1] != null) &&
              _isWhite) {
            // take over the squar at that position
            candidateMoves.add([row + direction, col + 1]);
          }
          if (isInBoard(row + direction, col - 1) &&
              (_board[row + direction][col - 1] != null) &&
              _isWhite) {
            // take over the squar at that position
            candidateMoves.add([row + direction, col - 1]);
          }
        }
      case ChessPieceType.bishop:
      case ChessPieceType.rook:
      case ChessPieceType.king:
      case ChessPieceType.queen:
      case ChessPieceType.knight:
        break;
      default:
    }
    return candidateMoves;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemCount: 8 * 8,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          int row = index ~/ 8;
          int column = index % 8;
          final piece = _board[row][column];
          bool isValidMove = false;
          for (var position in _validMoves) {
            if (position[0] == row && position[1] == column) {
              isValidMove = true;
              break;
            }
          }
          return Square(
            isWhite: isWhite(index),
            piece: piece,
            isValidMove: isValidMove, //_validMoves.contains([row, column]),
            isSelected: _selectedRow == row && _selectedColumn == column,
            onTap: () => _selectPiece(row, column),
          );
        },
      ),
    );
  }
}
