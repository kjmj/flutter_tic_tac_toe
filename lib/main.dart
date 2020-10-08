import 'package:flutter/material.dart';
import 'package:flutter_tic_tac_toe/board.dart';
import 'package:flutter_tic_tac_toe/board_model.dart';
import 'package:flutter_tic_tac_toe/game_end_message.dart';
import 'package:flutter_tic_tac_toe/turn_tracker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => BoardModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
