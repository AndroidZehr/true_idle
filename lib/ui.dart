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

    final tealPaint = Paint()
      ..color = const Color.fromARGB(255, 0, 247, 255).withValues(alpha: 0.45);

    final rect = RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(45),
    );

    canvas.drawRRect(rect, tealPaint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: 'Cash: ${game.money.value}',
        style: const TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black,
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

class CashDisplayBackground extends PositionComponent {
  CashDisplayBackground({required super.position, required super.size});

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = Colors.white;

    final rect = RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(45),
    );

    canvas.drawRRect(rect, paint);
  }
}
