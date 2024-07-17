import 'dart:math';

import 'package:flutter/material.dart';

class BubbleEffect extends CustomPainter {
  final BuildContext context;

  BubbleEffect(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2.2;
    final centerY = size.height;
    final radius = min(centerX, centerY)-30;

    final Paint circlePaint = Paint()..color = Theme.of(context).colorScheme.secondary.withOpacity(0.2);
    // left circle
    const Offset leftCircleOffSet = Offset(-50.0, 70.0);
    canvas.drawCircle(leftCircleOffSet, radius, circlePaint);

    // right circle
    final Offset rightCircleOffSet = Offset(size.width+60, 260.0);
    canvas.drawCircle(rightCircleOffSet, radius, circlePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}