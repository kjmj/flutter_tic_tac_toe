import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_tic_tac_toe/board.dart';

void main() {
  testWidgets('board starts empty', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Board()));

    expect(find.text(''), findsNWidgets(9));
  });

  testWidgets('x is the starting player', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Board()));
    await tester.tap(find.byKey(Key('board_GestureDetector_index_0')));
    await tester.pump();

    expect(find.text('x'), findsOneWidget);
    expect(find.text('o'), findsNothing);
    expect(find.text(''), findsNWidgets(8));
  });

  testWidgets('x and o alternate turns', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Board()));
    await tester.tap(find.byKey(Key('board_GestureDetector_index_0')));
    await tester.pump();

    expect(find.text('x'), findsOneWidget);
    expect(find.text('o'), findsNothing);

    await tester.tap(find.byKey(Key('board_GestureDetector_index_1')));
    await tester.pump();

    expect(find.text('o'), findsOneWidget);
  });

  testWidgets('tapping on a grid box that is occupied doesnt change the player',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Board()));
    await tester.tap(find.byKey(Key('board_GestureDetector_index_0')));
    await tester.pump();

    expect(find.text('x'), findsOneWidget);

    await tester.tap(find.byKey(Key('board_GestureDetector_index_0')));
    await tester.pump();

    expect(find.text('x'), findsOneWidget);
    expect(find.text('o'), findsNothing);
  });

  testWidgets('tapping on a grid box puts the mark in the correct spot',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Board()));
    await tester.tap(find.byKey(Key('board_GestureDetector_index_5')));
    await tester.pump();

    Text text = tester.firstWidget(find.byKey(Key('board_Text_index_5')));
    expect(text.data, 'x');
  });
}
