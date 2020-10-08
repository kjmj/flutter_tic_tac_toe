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
}
