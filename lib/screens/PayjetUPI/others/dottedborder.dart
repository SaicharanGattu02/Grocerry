import 'package:flutter/cupertino.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;

  DashedBorderPainter({
    required this.color,
    this.dashWidth = 1.0,
    this.dashSpace = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    path.addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    double distance = 0.0;
    while (distance < path.computeMetrics().first.length) {
      final segmentLength = dashWidth;
      final gapLength = dashSpace;

      final metric = path.computeMetrics().first;
      final segmentPath = Path();
      final segment = metric.extractPath(distance, distance + segmentLength);
      segmentPath.addPath(segment, Offset.zero);

      canvas.drawPath(segmentPath, paint);
      distance += segmentLength + gapLength;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}