import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Lines extends StatefulWidget {
  final Offset start, end;
  const Lines({Key key, this.start, this.end}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _Lines();
}

class _Lines extends State<Lines> with SingleTickerProviderStateMixin {
  double _progress = 1.0;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    var controller =
        AnimationController(duration: Duration(milliseconds: 250), vsync: this);

    animation = Tween(begin: 1.0, end: 0.0).animate(controller)
      ..addListener(() {
        setState(() {
          _progress = animation.value;
        });
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: LinePainter(widget.start, widget.end, _progress),
      child: Container(),
    );
  }
}

class LinePainter extends CustomPainter {
  final Offset _start, _end;
  double _progress;

  LinePainter(this._start, this._end, this._progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (_start == null || _end == null) return;

    Offset endProgress = _computeLineAnimationProgress();

    canvas.drawLine(
        _start,
        endProgress,
        Paint()
          ..strokeWidth = 8
          ..strokeCap = StrokeCap.round
          ..color = Colors.redAccent);
  }

  @override
  bool shouldRepaint(LinePainter oldDelegate) {
    return oldDelegate._progress != _progress;
  }

  /// Do a bunch of math to determine how long the line should be when animating
  /// from [_start] to [_end] given the [_progress]
  Offset _computeLineAnimationProgress() {
    var sdx = _start.dx * _progress;
    var sdy = _start.dy * _progress;
    var edx = _end.dx - _end.dx * _progress;
    var edy = _end.dy - _end.dy * _progress;
    var fdx = sdx + edx;
    var fdy = sdy + edy;

    return Offset(fdx, fdy);
  }
}
