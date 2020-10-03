import 'package:flutter/material.dart';

class Board extends StatefulWidget {
  @override
  _Board createState() => _Board();
}

class _Board extends State<Board> {
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  String currTurn = 'o';

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

  void _boxTapped(index) {
    setState(() {
      if (board[index] == '') {
        if (currTurn == 'o') {
          board[index] = 'o';
          currTurn = 'x';
        } else {
          board[index] = 'x';
          currTurn = 'o';
        }
      }
    });
  }
}
