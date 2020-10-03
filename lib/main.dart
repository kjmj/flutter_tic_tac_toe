import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  List<String> board = ['', '', '', '', '', '', '', '', ''];
  String currTurn = 'o';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      body: GridView.builder(
        itemCount: 9,
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
      ),
    );
  }

  void _boxTapped(index) {
    setState(() {
      if(board[index] == '') {
        if(currTurn == 'o') {
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
