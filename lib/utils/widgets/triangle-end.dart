import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color color;
  TrianglePainter({required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;

    var path = Path();
    path.moveTo(0, 0); // Top-left corner
    path.lineTo(0, size.height); // Bottom-left corner
    path.lineTo(size.height,
        size.height); // Bottom-right corner (isosceles right triangle)
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
