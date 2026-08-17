import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'true_idle_game.dart';

class CashDisplay extends StatelessWidget {
  final TrueIdleGame game;

  const CashDisplay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Opacity(
        opacity: 0.5,
        child: Container(
          margin: const EdgeInsets.only(
            //const EdgeInsets.all(20),
            top: 46,
            bottom: 20,
            left: 20,
            right: 10,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 247, 255),
            borderRadius: BorderRadius.circular(45),
          ),
          //color: Colors.white,
          child: ValueListenableBuilder<int>(
            valueListenable: game.money,
            builder: (context, money, child) {
              return Text(
                'Cash: $money',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 10, 10, 10),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CashDisplayBackground extends PositionComponent {
  CashDisplayBackground({required super.position, required super.size});

  @override
  void render(Canvas canvas) {
    final color = Paint()..color = Colors.white.withValues(alpha: 0.25);

    final rect = RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(45),
    );

    canvas.drawRRect(rect, color)
  }
}
