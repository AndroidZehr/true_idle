import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class WindowsComponent extends SpriteComponent with TapCallbacks {
  final TrueIdleGame game;

  WindowsComponent({required this.game, required super.sprite})
    : super(size: Vector2(75, 75), position: Vector2(500, 500));

  @override
  void onTapDown(TapDownEvent event) {
    game.money.value++;
    print('Money: ${game.money.value}');
  }
}

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

class EnemyComponent extends SpriteComponent {
  final double speed;
  EnemyComponent({this.speed = 50, required super.sprite})
    : super(size: Vector2(32, 32), position: Vector2(150, 150));

  @override
  void update(double dt) {
    super.update(dt);
    position.y += speed * dt;
  }
}

class TrueIdleGame extends FlameGame {
  ValueNotifier<int> money = ValueNotifier<int>(0);

  @override
  Color backgroundColor() => Colors.black;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final image = await images.load('windows.png');
    final enemy1 = await images.load('Enemy1.png');
    final gameAreaHeight = size.y * 0.48;

    add(WindowsComponent(game: this, sprite: Sprite(image)));
    add(EnemyComponent(sprite: Sprite(enemy1)));

    // Top border
    add(
      BorderComponent(
        position: Vector2(4, 4),
        size: Vector2(size.x - 8, gameAreaHeight - 8),
      ),
    );

    // Bottom border
    add(
      BorderComponent(
        position: Vector2(4, gameAreaHeight + 4),
        size: Vector2(size.x - 8, size.y - gameAreaHeight - 8),
      ),
    );
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

void main() {
  final game = TrueIdleGame();

  runApp(
    GameWidget(
      game: game,
      overlayBuilderMap: {
        'cash': (context, game) {
          return CashDisplay(game: game as TrueIdleGame);
        },
      },
      initialActiveOverlays: const ['cash'],
    ),
  );
}
