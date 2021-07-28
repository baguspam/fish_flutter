import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WaveShape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100.0,
      child: CustomPaint(
        painter: _MyPainter1(),
      ),
    );
  }
}

class _MyPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double innerCircleRadius = 150.0;
    var paint = Paint();
    paint.color = Colors.blue;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, size.height * 0.25);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2, size.width, size.height * 0.25);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2 - (innerCircleRadius / 2) - 30, size.height + 15, size.width / 2 - 75, size.height + 50);
    path.cubicTo(
        size.width / 2 - 40, size.height + innerCircleRadius - 40,
        size.width / 2 + 40, size.height + innerCircleRadius - 40,
        size.width / 2 + 75, size.height + 50
    );
    path.quadraticBezierTo(size.width / 2 + (innerCircleRadius / 2) + 30, size.height + 15, size.width, size.height);
    path.lineTo(size.width, 0.0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
