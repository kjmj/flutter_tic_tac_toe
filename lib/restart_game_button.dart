import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tic_tac_toe/board_model.dart';

class RestartGameButton extends StatelessWidget {
  const RestartGameButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(
      builder: (context, boardModel, child) {
        return ElevatedButton(
          child: Text('Restart'),
          onPressed: () => _restartGame(boardModel),
        );
      },
    );
  }

  void _restartGame(BoardModel boardModel) {
    _resetBoard(boardModel);
    _clearLine(boardModel);
    boardModel.gameEndMessage = '';
  }

  /// Clears the board, resets the current player
  void _resetBoard(BoardModel boardModel) {
    boardModel.clearBoard();
    boardModel.xTurn = true;
  }

  /// Clear the drawn line from the screen
  void _clearLine(BoardModel boardModel) {
    boardModel.winOffset1 = null;
    boardModel.winOffset2 = null;
  }
}
