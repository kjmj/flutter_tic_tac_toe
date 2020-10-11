import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tic_tac_toe/widgets/board.dart';
import 'package:flutter_tic_tac_toe/models/board_model.dart';
import 'package:flutter_tic_tac_toe/widgets/game_end_message.dart';
import 'package:flutter_tic_tac_toe/widgets/restart_game_button.dart';
import 'package:flutter_tic_tac_toe/widgets/turn_tracker.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BoardModel(),
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        accentColor: Colors.orange,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        accentColor: Colors.orange,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            child: Container(
              child: Column(
                children: [
                  TurnTracker(),
                  GameEndMessage(),
                  Board(),
                  RestartGameButton(),
                ],
              ),
            ),
            padding: EdgeInsets.all(15),
          ),
        ),
      ),
    );
  }
}
