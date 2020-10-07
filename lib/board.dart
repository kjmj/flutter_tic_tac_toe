import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/lines.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'board_cell.dart';
import 'board_model.dart';

class Board extends StatefulWidget {
  @override
  _Board createState() => _Board();
}

class _Board extends State<Board> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  List<GlobalKey> keys = []; // give each grid piece a corresponding key
  Offset widgetRootOffset; // offset of the root widget from the point (0, 0)

  // the offset of the two points that won the game
  Offset winOffset1;
  Offset winOffset2;

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widgetRootOffset = _getOffset(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    keys = [];

    return Stack(
      children: [
        GridView.builder(
          shrinkWrap: true,
          itemCount: 9,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (context, index) {
            GlobalKey pointKey = GlobalKey();
            keys.add(pointKey);

            return BoardCell(
              pointKey: pointKey,
              player: board[index],
              index: index,
              onTapped: () => _boxTapped(index),
            );
          },
        ),
        Lines(
          start: winOffset1,
          end: winOffset2,
        ),
      ],
    );
  }

  /// Updates the state of the board, determines if any dialogs should be shown,
  /// and changes the current player
  void _boxTapped(index) {
    var boardModel = Provider.of<BoardModel>(context, listen: false);

    if (board[index] == '') {
      setState(() {
        boardModel.xTurn ? board[index] = 'x' : board[index] = 'o';
      });

      final winningPoints = _getWinningPoints();
      if (winningPoints != null) {
        // update the offset of the winning points so a line can be drawn
        setState(() {
          winOffset1 =
              _getOffset(winningPoints.item1.currentContext) - widgetRootOffset;
          winOffset2 =
              _getOffset(winningPoints.item2.currentContext) - widgetRootOffset;
        });

        _winDialog();
      } else if (!board.contains('')) {
        _drawDialog();
      } else {
        boardModel.xTurn = !boardModel.xTurn;
      }
    }
  }

  /// Given the state of the [board], if there is a winner, return a [Tuple2]
  /// representing the two points that the game was won on. Otherwise, return null.
  Tuple2<GlobalKey, GlobalKey> _getWinningPoints() {
    if (board[0] == board[1] && board[1] == board[2] && board[0] != '') {
      return Tuple2(keys[0], keys[2]);
    } else if (board[3] == board[4] && board[4] == board[5] && board[3] != '') {
      return Tuple2(keys[3], keys[5]);
    } else if (board[6] == board[7] && board[7] == board[8] && board[6] != '') {
      return Tuple2(keys[6], keys[8]);
    } else if (board[0] == board[3] && board[3] == board[6] && board[0] != '') {
      return Tuple2(keys[0], keys[6]);
    } else if (board[1] == board[4] && board[4] == board[7] && board[1] != '') {
      return Tuple2(keys[1], keys[7]);
    } else if (board[2] == board[5] && board[5] == board[8] && board[2] != '') {
      return Tuple2(keys[2], keys[8]);
    } else if (board[0] == board[4] && board[4] == board[8] && board[0] != '') {
      return Tuple2(keys[0], keys[8]);
    } else if (board[2] == board[4] && board[4] == board[6] && board[2] != '') {
      return Tuple2(keys[2], keys[6]);
    } else {
      return null;
    }
  }

  /// Generic dialog to be shown at the end of a game containing [title]
  /// This dialog will reset the board if they choose to play again
  Future<void> _endOfGameDialog(String title) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          key: Key('board_AlertDialog'),
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('Play again'),
              onPressed: () {
                _resetBoard();
                _clearLine();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  /// Dialog for when there is a winner
  Future<void> _winDialog() async {
    var boardModel = Provider.of<BoardModel>(context, listen: false);

    String currPlayer = boardModel.xTurn ? 'x' : 'o';
    return _endOfGameDialog('Player ' + currPlayer + ' has won!');
  }

  /// Dialog for when there is a draw
  Future<void> _drawDialog() async {
    return _endOfGameDialog('Draw, nobody won!');
  }

  /// Clears the board, resets the current player
  void _resetBoard() {
    var boardModel = Provider.of<BoardModel>(context, listen: false);

    for (int i = 0; i < board.length; i++) {
      setState(() {
        board[i] = '';
      });
    }
    boardModel.xTurn = true;
  }

  /// Get the offset of a given [context] from [Offset.zero]
  /// todo this should be moved into a shared service class
  Offset _getOffset(BuildContext context) {
    final RenderBox renderObject = context.findRenderObject();
    return renderObject.localToGlobal(Offset.zero);
  }

  /// Clear the drawn line from the screen
  void _clearLine() {
    setState(() {
      winOffset1 = null;
      winOffset2 = null;
    });
  }
}
