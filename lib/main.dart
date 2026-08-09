import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/rendering.dart';

//top section
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

class PlayerComponent extends SpriteComponent {
  PlayerComponent({required super.sprite, required Vector2 position})
    : super(size: Vector2(50, 50), position: position);
}

class EnemyComponent extends SpriteComponent {
  final Vector2 target;
  final double speed;

  EnemyComponent({
    required super.sprite,
    required this.target,
    required Vector2 spawnPosition,
    this.speed = 50,
  }) : super(size: Vector2(32, 32), position: spawnPosition);

  @override
  void update(double dt) {
    super.update(dt);

    final direction = target - position;
    direction.normalize();

    angle = atan2(direction.x, direction.y);
    position += direction * speed * dt;
  }
}

//bottom section
class PlusOne extends SpriteComponent with TapCallbacks {
  final TrueIdleGame game;
  final Sprite normalSprite;
  final Sprite pressedSprite;

  PlusOne({
    required this.game,
    required this.normalSprite,
    required this.pressedSprite,
  }) : super(
         sprite: normalSprite,
         size: Vector2(225, 75),
         position: Vector2(450, 500),
       );

  @override
  void onTapDown(TapDownEvent event) {
    sprite = pressedSprite;
    game.money.value++;
  }

  @override
  void onTapUp(TapUpEvent event) {
    sprite = normalSprite;
  }
}

//other
class TrueIdleGame extends FlameGame {
  ValueNotifier<int> money = ValueNotifier<int>(0);

  @override
  Color backgroundColor() => const Color.fromARGB(255, 53, 53, 53);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final addd = await images.load('PlusOne.png');
    final addd_pressed = await images.load('PlusOne_pressed.png');
    final enemy1 = await images.load('Enemy1.png');
    final playerSprite = await images.load('Player.png');

    final gameAreaHeight = size.y * 0.48;
    final playerPosition = Vector2(size.x / 2, gameAreaHeight / 2);

    add(
      PlusOne(
        game: this,
        normalSprite: Sprite(addd),
        pressedSprite: Sprite(addd_pressed),
      ),
    );
    add(
      PlayerComponent(sprite: Sprite(playerSprite), position: playerPosition),
    );
    spawnEnemy(Sprite(enemy1), playerPosition, gameAreaHeight);

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

  void spawnEnemy(Sprite sprite, Vector2 target, double gameAreaHeight) {
    final random = Random();
    final side = random.nextInt(4);
    late Vector2 spawnPosition;

    switch (side) {
      case 0: //top
        spawnPosition = Vector2(random.nextDouble() * size.x, -40);
        break;
      case 1: //bottom
        spawnPosition = Vector2(
          random.nextDouble() * size.x,
          gameAreaHeight + 40,
        );
        break;
      case 2: //left
        spawnPosition = Vector2(-40, random.nextDouble() * gameAreaHeight);
        break;
      default: // Right
        spawnPosition = Vector2(
          size.x + 40,
          random.nextDouble() * gameAreaHeight,
        );
    }

    final enemy = EnemyComponent(
      sprite: sprite,
      target: target,
      spawnPosition: spawnPosition,
    );
    add(enemy);
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
