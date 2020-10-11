import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'package:flutter_tic_tac_toe/widgets/board_cell.dart';
import 'package:flutter_tic_tac_toe/models/board_model.dart';
import 'package:flutter_tic_tac_toe/widgets/lines.dart';

class Board extends StatefulWidget {
  @override
  _Board createState() => _Board();
}

class _Board extends State<Board> {
  List<GlobalKey> keys =
      new List(9); // give each grid piece a corresponding key
  Offset widgetRootOffset; // offset of the root widget from the point (0, 0)

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => widgetRootOffset = _getOffset(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardModel>(
      builder: (context, boardModel, child) {
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
                keys[index] = pointKey;

                return BoardCell(
                  pointKey: pointKey,
                  player: boardModel.board[index],
                  index: index,
                  onTapped: () => _boxTapped(index, boardModel),
                  isGameOver: _isWinner(boardModel.board),
                );
              },
            ),
            _isWinner(boardModel.board)
                ? Lines(
                    start: boardModel.winOffset1,
                    end: boardModel.winOffset2,
                  )
                : Container(),
          ],
        );
      },
    );
  }

  /// Updates the state of the board, determines if any dialogs should be shown,
  /// and changes the current player
  void _boxTapped(int index, BoardModel boardModel) {
    List<String> board = boardModel.board;

    if (board[index] == '') {
      boardModel.xTurn
          ? boardModel.addToBoard('x', index)
          : boardModel.addToBoard('o', index);

      if (_isWinner(board)) {
        // update the offset of the winning points so a line can be drawn
        final winningPoints = _getWinningPoints(board);
        boardModel.winOffset1 =
            _getOffset(winningPoints.item1.currentContext) - widgetRootOffset;
        boardModel.winOffset2 =
            _getOffset(winningPoints.item2.currentContext) - widgetRootOffset;

        String currPlayer = boardModel.xTurn ? 'x' : 'o';
        boardModel.gameEndMessage = 'Player ' + currPlayer + ' has won!';
      } else if (!board.contains('')) {
        boardModel.gameEndMessage = 'Draw, nobody won!';
      } else {
        boardModel.xTurn = !boardModel.xTurn;
      }
    }
  }

  /// Given the state of the [board], if there is a winner, return a [Tuple2]
  /// representing the two points that the game was won on. Otherwise, return null.
  Tuple2<GlobalKey, GlobalKey> _getWinningPoints(List<String> board) {
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

  /// Return true if there is a winner given [board], false otherwise
  bool _isWinner(List<String> board) {
    return _getWinningPoints(board) != null ? true : false;
  }

  /// Get the offset of a given [context] from [Offset.zero]
  /// todo this should be moved into a shared service class
  Offset _getOffset(BuildContext context) {
    final RenderBox renderObject = context.findRenderObject();
    return renderObject.localToGlobal(Offset.zero);
  }
}
