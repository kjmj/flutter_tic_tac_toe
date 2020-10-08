import 'package:flutter/material.dart';

class BoardCell extends StatelessWidget {
  const BoardCell({
    Key key,
    @required this.pointKey,
    @required this.player,
    @required this.index,
    @required this.onTapped,
    @required this.isGameOver,
  }) : super(key: key);

  final GlobalKey<State<StatefulWidget>> pointKey;
  final String player;
  final int index;
  final VoidCallback onTapped;
  final bool isGameOver;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: isGameOver,
      child: GestureDetector(
        key: Key('board_GestureDetector_index_' + index.toString()),
        onTap: () => onTapped(),
        child: Container(
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 0,
                  width: 0,
                  key: pointKey,
                ),
                Text(
                  player,
                  key: Key('board_Text_index_' + index.toString()),
                  style: TextStyle(color: Colors.white, fontSize: 36),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
