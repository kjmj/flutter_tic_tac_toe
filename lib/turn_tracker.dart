import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tic_tac_toe/board_model.dart';

class TurnTracker extends StatefulWidget {
  @override
  _TurnTracker createState() => _TurnTracker();
}

class _TurnTracker extends State<TurnTracker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(
      builder: (context, boardModel, child) {
        String currTurn = boardModel.xTurn ? 'x' : 'o';
        return Text(
          'Current Turn: ' + currTurn,
          style: TextStyle(
            fontSize: 36,
          ),
        );
      },
    );
  }
}
