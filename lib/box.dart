import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BoxComponent extends PositionComponent {
  final double borderRadius;
  double opacity;
  Color color;

  BoxComponent({
    required super.position,
    required super.size,
    this.borderRadius = 8,
    this.opacity = 1.0,
    this.color = const Color.fromARGB(255, 0, 0, 0),
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
      ..color = color.withOpacity(opacity)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(rect, backgroundPaint);

    // Border
    final borderPaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawRRect(rect, borderPaint);
  }
}
