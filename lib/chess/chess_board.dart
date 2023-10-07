// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:shopy/chess/captured_piece.dart';
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
  List<List<int>> _validMoves = [];
  List<ChessPiece> _whitePiecesTaken = [];
  List<ChessPiece> _blackPiecesTaken = [];
  ChessPiece? _selectedPiece;
  int _selectedRow = -1;
  int _selectedColumn = -1;
  bool _isWhiteTurn = true;
  List<int> whiteKingPostion = [7, 4];
  List<int> blackKingPostion = [0, 4];
  bool checkStatus = false;
  @override
  void initState() {
    super.initState();
    _board = initBorad();
  }

  // void _selectPiece(int row, int col) {
  //   if (_board[row][col] != null) {
  //     if (_selectedPiece != _board[row][col]) {
  //       setState(() {
  //         _selectedPiece = _board[row][col];
  //         _selectedRow = row;
  //         _selectedColumn = col;
  //       });
  //       _validMoves = _calculateRawValidMoves(
  //         _selectedRow,
  //         _selectedColumn,
  //         _selectedPiece,
  //       );
  //     } else {
  //       setState(() {
  //         _selectedPiece = null;
  //         _selectedRow = -1;
  //         _selectedColumn = -1;
  //         _validMoves = [];
  //       });
  //     }
  //   } else if (_selectedPiece != null &&
  //       _validMoves.any((e) => row == e[0] && col == e[1])) {
  //     _movePiece(row, col);
  //   }
  // }
  void _selectPiece(int row, int col) {
    setState(() {
      // no piece ha been selected yet, this is the first selection
      if (_selectedPiece == null && _board[row][col] != null) {
        if (_board[row][col]!.isWhite == _isWhiteTurn) {
          _selectedPiece = _board[row][col];
          _selectedRow = row;
          _selectedColumn = col;
        }
      }

      //there is already a piece selected but player can select another one of its own pieces
      else if (_board[row][col] != null &&
          _board[row][col]!.isWhite == _selectedPiece!.isWhite) {
        _selectedPiece = _board[row][col];
        _selectedRow = row;
        _selectedColumn = col;
      }
      // if there is a selected piece and player taps on a square that is a valid move, move the piece to that square
      else if (_selectedPiece != null &&
          _validMoves.any((e) => row == e[0] && col == e[1])) {
        _movePiece(row, col);
      }
      // if a piece is selceted, calcutate its valid moves
      _validMoves = _calculateRealValidMoves(
        _selectedRow,
        _selectedColumn,
        _selectedPiece,
        true,
      );
    });
  }

  List<List<int>> _calculateRawValidMoves(
    int row,
    int col,
    ChessPiece? piece,
  ) {
    List<List<int>> candidateMoves = [];
    //Direction direction =
    //piece!.color == Colors.white ? Direction.up : Direction.down;
    // we can use -1  for up and +1 for down
    if (piece == null) return [];
    int direction = piece.isWhite ? -1 : 1;

    switch (piece.type) {
      case ChessPieceType.pawne:

        // PAWns can move one square forward
        _movePawn(row, direction, col, candidateMoves, piece);
        break;

      case ChessPieceType.bishop:
        _moveBishop(row, col, piece, candidateMoves);
        break;
      case ChessPieceType.rook:
        _moveRook(row, col, piece, candidateMoves);
        break;
      case ChessPieceType.king:
        _moveKing(row, col, piece, candidateMoves);
        break;
      case ChessPieceType.queen:
        _moveQueen(row, col, piece, candidateMoves);
        break;
      case ChessPieceType.knight:
        _moveKnight(row, col, piece, candidateMoves);
        break;
      default:
    }
    return candidateMoves;
  }

  List<List<int>> _calculateRealValidMoves(
    int row,
    int col,
    ChessPiece? piece,
    bool checkSimulation,
  ) {
    List<List<int>> realValidMoves = [];
    List<List<int>> candidateMoves = _calculateRawValidMoves(row, col, piece);
    // after calculating all candidate moves, we fliter out the moves that put the king under check
    if (checkSimulation) {
      for (var move in candidateMoves) {
        int endRow = move[0];
        int endCol = move[1];
        // this will simulate the future move to see if its safe
        if (_simulatedMoveIsSafe(piece!, row, col, endRow, endCol)) {
          realValidMoves.add(move);
        }
      }
    } else {
      realValidMoves = candidateMoves;
    }
    return realValidMoves;
  }

// simulate the future move to see if its safe = it doesn't put our king under attack
  bool _simulatedMoveIsSafe(
    ChessPiece piece,
    int startRow,
    int startCol,
    int endRow,
    int endCol,
  ) {
    // save the current board state
    ChessPiece? orignalDestinationPiece = _board[endRow][endCol];
    // if the piece is a king, save its current position and update it to the new one
    List<int>? originalKingPosition;
    if (piece.type == ChessPieceType.king) {
      originalKingPosition =
          piece.isWhite ? whiteKingPostion : blackKingPostion;
      // update the king position
      if (piece.isWhite) {
        whiteKingPostion = [endRow, endCol];
      } else {
        blackKingPostion = [endRow, endCol];
      }
    }

    // simulate move
    _board[endRow][endCol] = piece;
    _board[startRow][startCol] = null;
    // check if our own king is under attack
    bool isKingUnderCheck = _isKingInCheck(piece.isWhite);
    // restore the board to original state

    _board[startRow][startCol] = piece;
    _board[endRow][endCol] = orignalDestinationPiece;

    // if the piece was a king, restore it original position
    if (piece.type == ChessPieceType.king) {
      if (piece.isWhite) {
        whiteKingPostion = originalKingPosition!;
      } else {
        blackKingPostion = originalKingPosition!;
      }
    }
    // if king is in check then not a safe move
    return !isKingUnderCheck;
  }

  void _movePiece(int newRow, int newCol) {
    // check if we caputer an enemy piece == the new spot has an enmy piece
    if (_board[newRow][newCol] != null) {
      // add the caputred piece to the appropriate list of captured pieces
      var caputerdPiece = _board[newRow][newCol];
      caputerdPiece!.isWhite
          ? _whitePiecesTaken.add(caputerdPiece)
          : _blackPiecesTaken.add(caputerdPiece);
    }

    // check if the piece being moved is a king
    if (_selectedPiece!.type == ChessPieceType.king) {
      // update the appropriate king position
      if (_selectedPiece!.isWhite) {
        whiteKingPostion = [newRow, newCol];
      } else {
        blackKingPostion = [newRow, newCol];
      }
    }
    // move piece to new row  and column and clear the old square then init the selcted data
    _board[newRow][newCol] = _selectedPiece;
    _board[_selectedRow][_selectedColumn] = null;

    // check if any of the kings ia under attack
    if (_isKingInCheck(!_isWhiteTurn)) {
      checkStatus = true;
    } else {
      checkStatus = false;
    }
    setState(() {
      _selectedRow = -1;
      _selectedColumn = -1;
      _selectedPiece = null;
      _validMoves = [];
    });
    //Change turns
    _isWhiteTurn = !_isWhiteTurn;
  }

  bool _isKingInCheck(bool isWhiteKing) {
    List<int> kingPosition = isWhiteKing ? whiteKingPostion : blackKingPostion;
    // check if any enemy piece can attack the king
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        // skipp the empty square and the pieces that have the same color as the king
        if (_board[i][j] == null || _board[i][j]!.isWhite == isWhiteKing) {
          continue;
        }
        List<List<int>> pieceValidMoves =
            _calculateRealValidMoves(i, j, _board[i][j], false);
        // check if king position is in any of the valid moves
        if (pieceValidMoves.any((move) =>
            move[0] == kingPosition[0] && move[1] == kingPosition[1])) {
          return true;
        }
      }
    }
    return false;
  }

  void _moveKing(
      int row, int col, ChessPiece piece, List<List<int>> candidateMoves) {
    {
      const directions = [
        [-1, 0], //up
        [1, 0], //down
        [0, -1], //left
        [0, 1], //right
        [-1, -1], // up left
        [-1, 1], //up right
        [1, -1], //down left
        [1, 1], //down right
      ];
      for (var direction in directions) {
        int newRow = row + direction[0];
        int newCol = col + direction[1];

        if (!isInBoard(newRow, newCol)) {
          continue;
        }
        if (_board[newRow][newCol] != null) {
          // kill the piece
          //TODO: this has to be redone after because king can be cheched
          if (_board[newRow][newCol]!.isWhite != piece.isWhite) {
            candidateMoves.add([newRow, newCol]);
          }
          continue; // blocked by own piece
        }
        candidateMoves.add([newRow, newCol]);
      }
    }
  }

  void _moveRook(
      int row, int col, ChessPiece piece, List<List<int>> candidateMoves) {
    {
      const directions = [
        //up
        [-1, 0],
        //down
        [1, 0],
        //left
        [0, -1],
        //right
        [0, 1],
      ];
      for (var direction in directions) {
        int i = 1;
        while (true) {
          int newRow = row + i * direction[0];
          int newCol = col + i * direction[1];

          if (!isInBoard(newRow, newCol)) {
            break;
          }
          if (_board[newRow][newCol] != null) {
            if (_board[newRow][newCol]!.isWhite != piece.isWhite) {
              // kill the piece of the  opponent
              candidateMoves.add([newRow, newCol]);
            } else {
              // my own piece is blocking the rook because its the same color
              break;
            }
          } else {
            candidateMoves.add([newRow, newCol]);
          }

          i++;
        }
      }
    }
  }

  void _moveQueen(
      int row, int col, ChessPiece piece, List<List<int>> candidateMoves) {
    {
      const directions = [
        [-1, 0], //up
        [1, 0], //down
        [0, -1], //left
        [0, 1], //right
        [-1, -1], // up left
        [-1, 1], //up right
        [1, -1], //down left
        [1, 1], //down right
      ];
      for (var direction in directions) {
        int i = 1;
        while (true) {
          int newRow = row + i * direction[0];
          int newCol = col + i * direction[1];
          if (!isInBoard(newRow, newCol)) {
            break;
          }
          if (_board[newRow][newCol] != null) {
            if (_board[newRow][newCol]!.isWhite != piece.isWhite) {
              // kill move
              candidateMoves.add([newRow, newCol]);
              break;
            } else {
              break;
            }
          } else {
            candidateMoves.add([newRow, newCol]);
          }
          i++;
        }
      }
    }
  }

  void _moveKnight(
      int row, int col, ChessPiece piece, List<List<int>> candidateMoves) {
    const knightMoves = [
      [-2, -1], // up 2 left 1
      [-2, 1], // up 2 right 1
      [-1, -2], // up 1 left 2
      [-1, 2], // up 1 right 2

      [1, -2], // down 1 left 2
      [1, 2], // down 1 right 2
      [2, -1], // down 2 left 1
      [2, 1], // down 2 right 1
    ];
    for (var knightMove in knightMoves) {
      int newRow = row + knightMove[0];
      int newCol = col + knightMove[1];
      if (!isInBoard(newRow, newCol)) {
        continue;
      }
      if (_board[newRow][newCol] != null) {
        if (piece.isWhite != _board[newRow][newCol]!.isWhite) {
          // kill the piece
          candidateMoves.add([newRow, newCol]);
        }
        continue;
      }
      candidateMoves.add([newRow, newCol]);
    }
  }

  void _movePawn(int row, int direction, int col,
      List<List<int>> candidateMoves, ChessPiece piece) {
    // PAWns can move one square forward
    if (isInBoard(row + direction, col) &&
        _board[row + direction][col] == null) {
      candidateMoves.add([row + direction, col]);
    }
    // pawns can move 2 square forward if they are at initial position 6th row for black and 2nd row for whites
    if ((row == 1 && !piece.isWhite) || (row == 6 && piece.isWhite)) {
      if (isInBoard(row + 2 * direction, col) &&
          _board[row + direction][col] == null &&
          _board[row + 2 * direction][col] == null) {
        candidateMoves.add([row + 2 * direction, col]);
      }
    }
    // PAWNS can kill diagonally and take the space
    if (isInBoard(row + direction, col + 1) &&
        (_board[row + direction][col + 1] != null) &&
        (piece.isWhite != _board[row + direction][col + 1]!.isWhite)) {
      // take over the squar at that position
      candidateMoves.add([row + direction, col + 1]);
    }
    if (isInBoard(row + direction, col - 1) &&
        (_board[row + direction][col - 1] != null) &&
        (piece.isWhite != _board[row + direction][col - 1]!.isWhite)) {
      // take over the squar at that position
      candidateMoves.add([row + direction, col - 1]);
    }
  }

  void _moveBishop(
      int row, int col, ChessPiece piece, List<List<int>> candidateMoves) {
    {
      const directions = [
        [-1, -1], //up left
        [-1, 1], //up right
        [1, -1], //down left
        [1, 1], //down right
      ];
      for (var direction in directions) {
        int i = 1;
        while (true) {
          int newRow = row + i * direction[0];
          int newCol = col + i * direction[1];

          if (!isInBoard(newRow, newCol)) {
            break;
          }
          if (_board[newRow][newCol] != null) {
            if (_board[newRow][newCol]!.isWhite != piece.isWhite) {
              // kill the piece of the  opponent
              candidateMoves.add([newRow, newCol]);
              break;
            } else {
              // my own piece is blocking the rook because its the same color
              break;
            }
          } else {
            candidateMoves.add([newRow, newCol]);
          }

          i++;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemCount: _whitePiecesTaken.length,
              itemBuilder: (context, index) => CapturedPiece(
                piece: _whitePiecesTaken[index],
              ),
            ),
          ),
          //Diplay Check Status
          if (checkStatus) const Text('CHECK!!'),
          Expanded(
            flex: 3,
            child: GridView.builder(
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
                  isWhite: isSquareWhite(index),
                  piece: piece,
                  isValidMove:
                      isValidMove, //_validMoves.contains([row, column]),
                  isSelected: _selectedRow == row && _selectedColumn == column,
                  onTap: () => _selectPiece(row, column),
                );
              },
            ),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
              ),
              itemCount: _blackPiecesTaken.length,
              itemBuilder: (context, index) => CapturedPiece(
                piece: _blackPiecesTaken[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
