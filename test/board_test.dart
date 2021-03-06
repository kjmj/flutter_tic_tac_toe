import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_tic_tac_toe/widgets/board.dart';
import 'package:flutter_tic_tac_toe/models/board_model.dart';
import 'package:flutter_tic_tac_toe/global_vars/global_vars.dart';

Widget mockBoard = MaterialApp(
  home: ChangeNotifierProvider(
    create: (context) => BoardModel(),
    child: Scaffold(
      body: Board(),
    ),
  ),
);


void main() {
  testWidgets('board starts empty', (WidgetTester tester) async {
    await tester.pumpWidget(mockBoard);

    expect(find.byIcon(GlobalVars.blankIcon), findsNWidgets(9));
  });

  testWidgets('x is the starting player', (WidgetTester tester) async {
    await tester.pumpWidget(mockBoard);
    await tester.tap(find.byKey(Key('board_GestureDetector_index_0')));
    await tester.pump();

    expect(find.byIcon(GlobalVars.xIcon), findsOneWidget);
    expect(find.byIcon(GlobalVars.oIcon), findsNothing);
    expect(find.byIcon(GlobalVars.blankIcon), findsNWidgets(8));
  });

  testWidgets('x and o alternate turns', (WidgetTester tester) async {
    await tester.pumpWidget(mockBoard);
    await tester.tap(find.byKey(Key('board_GestureDetector_index_0')));
    await tester.pump();

    expect(find.byIcon(GlobalVars.xIcon), findsOneWidget);
    expect(find.byIcon(GlobalVars.oIcon), findsNothing);

    await tester.tap(find.byKey(Key('board_GestureDetector_index_1')));
    await tester.pump();

    expect(find.byIcon(GlobalVars.oIcon), findsOneWidget);
  });

  testWidgets('tapping on a grid box that is occupied doesnt change the player',
      (WidgetTester tester) async {
    await tester.pumpWidget(mockBoard);
    await tester.tap(find.byKey(Key('board_GestureDetector_index_0')));
    await tester.pump();

    expect(find.byIcon(GlobalVars.xIcon), findsOneWidget);

    await tester.tap(find.byKey(Key('board_GestureDetector_index_0')));
    await tester.pump();

    expect(find.byIcon(GlobalVars.xIcon), findsOneWidget);
    expect(find.byIcon(GlobalVars.oIcon), findsNothing);
  });

  testWidgets('tapping on a grid box puts the mark in the correct spot',
      (WidgetTester tester) async {
    await tester.pumpWidget(mockBoard);
    await tester.tap(find.byKey(Key('board_GestureDetector_index_5')));
    await tester.pump();

    Icon icon = tester.firstWidget(find.byKey(Key('board_Icon_index_5')));
    expect(icon.icon, GlobalVars.xIcon);
  });
}
