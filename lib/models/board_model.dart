import 'package:flutter/material.dart';

class BoardModel extends ChangeNotifier {
  bool _xTurn = true; // x goes first
  bool get xTurn => _xTurn;
  set xTurn(bool val) {
    _xTurn = val;
    notifyListeners();
  }

  String _gameEndMessage;
  String get gameEndMessage => _gameEndMessage;
  set gameEndMessage(String val) {
    _gameEndMessage = val;
    notifyListeners();
  }

  List<String> _board = ['', '', '', '', '', '', '', '', ''];
  List<String> get board => _board;
  void addToBoard(String player, int index) {
    _board[index] = player;
    notifyListeners();
  }

  void clearBoard() {
    for (int i = 0; i < _board.length; i++) {
      board[i] = '';
    }
    notifyListeners();
  }

  // the offset of the two points that won the game
  Offset _winOffset1;
  Offset get winOffset1 => _winOffset1;
  set winOffset1(Offset val) {
    _winOffset1 = val;
    notifyListeners();
  }

  Offset _winOffset2;
  Offset get winOffset2 => _winOffset2;
  set winOffset2(Offset val) {
    _winOffset2 = val;
    notifyListeners();
  }
}
