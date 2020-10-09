import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'board_model.dart';

class GameEndMessage extends StatelessWidget {
  const GameEndMessage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(
      builder: (context, boardModel, child) {
        String message = boardModel.gameEndMessage;
        return Text(
          message == null ? '' : message,
          style: TextStyle(
            fontSize: 16,
          ),
        );
      },
    );
  }
}
