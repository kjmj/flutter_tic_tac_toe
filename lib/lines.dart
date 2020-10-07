import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Lines extends StatelessWidget {
  final Offset start, end;

  const Lines({Key key, this.start, this.end}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinesPainter(start, end),
    );
  }
}

class LinesPainter extends CustomPainter {
  final Offset start, end;

  LinesPainter(this.start, this.end);

  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) return;

    canvas.drawLine(
        start,
        end,
        Paint()
          ..strokeWidth = 4
          ..color = Colors.red);
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) {
    return oldDelegate.start != start || oldDelegate.end != end;
  }
}
