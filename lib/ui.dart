import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'true_idle_game.dart';

class CashDisplay extends PositionComponent {
  final TrueIdleGame game;

  CashDisplay({
    required this.game,
    required super.position,
    required super.size,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // Background
    final backgroundPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.5);

    final rect = RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(45),
    );

    canvas.drawRRect(rect, backgroundPaint);

    // Text
    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Cash: ${game.money.value}',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 10, 10, 10),
        ),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();

    textPainter.paint(
      canvas,
      Offset(
        (size.x - textPainter.width) / 2,
        (size.y - textPainter.height) / 2,
      ),
    );
  }
}
