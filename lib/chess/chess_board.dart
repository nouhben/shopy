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
    _board = Helper.initBorad();
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
    }
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
          return Square(
            isWhite: Helper.isWhite(index),
            piece: piece,
            isSelected: _selectedRow == row && _selectedColumn == column,
            onTap: () => _selectPiece(row, column),
          );
        },
      ),
    );
  }
}
