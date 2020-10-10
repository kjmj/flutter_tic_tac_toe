import 'package:flutter/material.dart';

import 'global_vars/global_vars.dart';

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
    ThemeData theme = Theme.of(context);
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
                FractionallySizedBox(
                  widthFactor: 0.9,
                  heightFactor: 0.9,
                  child: FittedBox(
                    fit: BoxFit.fitHeight,
                    child: Icon(
                      _getIcon(),
                      key: Key('board_Icon_index_' + index.toString()),
                      color: player == 'x'
                          ? theme.primaryColor
                          : theme.accentColor,
                    ),
                  ),
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

  /// Get the correct icon given the [player]
  IconData _getIcon() {
    IconData icon;

    if (player == 'x') {
      icon = GlobalVars.xIcon;
    } else if (player == 'o') {
      icon = GlobalVars.oIcon;
    }

    return icon;
  }
}
