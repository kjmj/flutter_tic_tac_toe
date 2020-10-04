import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  @override
  _Board createState() => _Board();
}

class _Board extends State<Board> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  bool xTurn = true; // x goes first

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 9,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            _boxTapped(index);
          },
          child: Container(
            child: Center(
              child: Text(
                board[index],
                style: TextStyle(color: Colors.white, fontSize: 36),
              ),
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
            ),
          ),
        );
      },
    );
  }

  /// Updates the state of the board, determines if any dialogs should be shown,
  /// and changes the current player
  void _boxTapped(index) {
    if (board[index] == '') {
      setState(() {
        xTurn ? board[index] = 'x' : board[index] = 'o';
      });
      if (_winner()) {
        _winDialog();
      } else if (!board.contains('')) {
        _drawDialog();
      } else {
        xTurn = !xTurn;
      }
    }
  }

  /// Returns true if there is a winner given the current state of the [board]
  bool _winner() {
    return (board[0] == board[1] && board[1] == board[2] && board[0] != '') ||
        (board[3] == board[4] && board[4] == board[5] && board[3] != '') ||
        (board[6] == board[7] && board[7] == board[8] && board[6] != '') ||
        (board[0] == board[3] && board[3] == board[6] && board[0] != '') ||
        (board[1] == board[4] && board[4] == board[7] && board[1] != '') ||
        (board[2] == board[5] && board[5] == board[8] && board[2] != '') ||
        (board[0] == board[4] && board[4] == board[8] && board[0] != '') ||
        (board[2] == board[4] && board[4] == board[6] && board[2] != '');
  }

  /// Generic dialog to be shown at the end of a game containing [title]
  /// This dialog will reset the board if they choose to play again
  Future<void> _endOfGameDialog(String title) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: <Widget>[
            TextButton(
              child: Text('Play again'),
              onPressed: () {
                _resetBoard();
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
    String currPlayer = xTurn ? 'x' : 'o';
    return _endOfGameDialog('Player ' + currPlayer + ' has won!');
  }

  /// Dialog for when there is a draw
  Future<void> _drawDialog() async {
    return _endOfGameDialog('Draw, nobody won!');
  }

  /// Clears the board, resets the current player
  void _resetBoard() {
    for (int i = 0; i < board.length; i++) {
      setState(() {
        board[i] = '';
      });
    }
    xTurn = true;
  }
}
