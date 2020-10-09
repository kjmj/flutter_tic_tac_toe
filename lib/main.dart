import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/board.dart';
import 'package:flutter_tic_tac_toe/board_model.dart';
import 'package:flutter_tic_tac_toe/game_end_message.dart';
import 'package:flutter_tic_tac_toe/restart_game_button.dart';
import 'package:flutter_tic_tac_toe/turn_tracker.dart';
import 'package:provider/provider.dart';

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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
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
      backgroundColor: Colors.white12,
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
