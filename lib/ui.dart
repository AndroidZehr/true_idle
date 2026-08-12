import 'package:flutter/material.dart';
import 'true_idle_game.dart';
import 'package:flame/components.dart';

class BorderComponent extends PositionComponent {
  final double borderRadius;

  BorderComponent({
    required super.position,
    required super.size,
    this.borderRadius = 8,
  });

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final rect = RRect.fromRectAndRadius(
      size.toRect(),
      Radius.circular(borderRadius),
    );

    canvas.drawRRect(rect, paint);
  }
}

class CashDisplay extends StatelessWidget {
  final TrueIdleGame game;

  const CashDisplay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: Colors.white,
        child: ValueListenableBuilder<int>(
          valueListenable: game.money,
          builder: (context, money, child) {
            return Text(
              'Cash: $money',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }
}
