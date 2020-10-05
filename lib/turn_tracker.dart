import 'package:flutter/material.dart';

class TurnTracker extends StatefulWidget {
  @override
  _TurnTracker createState() => _TurnTracker();
}

class _TurnTracker extends State<TurnTracker> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Current Turn: ',
      style: TextStyle(
        color: Colors.white,
        fontSize: 36,
      ),
    );
  }
}
