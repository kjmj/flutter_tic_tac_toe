import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'board_model.dart';

class TurnTracker extends StatefulWidget {
  @override
  _TurnTracker createState() => _TurnTracker();
}

class _TurnTracker extends State<TurnTracker> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(
      builder: (context, board, child) {
        var currTurn = board.xTurn ? 'x' : 'o';
        return Text(
          'Current Turn: ' + currTurn,
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
          ),
        );
      },
    );
  }
}
