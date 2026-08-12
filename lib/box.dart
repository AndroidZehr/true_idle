import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BoxComponent extends PositionComponent {
  final double borderRadius;

  BoxComponent({
    required super.position,
    required super.size,
    this.borderRadius = 8,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final rect = RRect.fromRectAndRadius(
      size.toRect(),
      Radius.circular(borderRadius),
    );

    // Background
    final backgroundPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rect, backgroundPaint);

    // Border
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(rect, borderPaint);
  }
}
