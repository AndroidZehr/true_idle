import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame/collisions.dart';

import 'box.dart';
import 'buttons.dart';
import 'enemies.dart';
import 'player.dart';

class TrueIdleGame extends FlameGame with HasCollisionDetection {
  ValueNotifier<int> money = ValueNotifier<int>(0);

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 3, 3, 3);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load images
    final plusOneIconImage = await images.load('PlusOne_icon.png');
    final enemyImage = await images.load('Enemy1.png');
    final playerImage = await images.load('Player.png');

    // --------------------------------------------------
    // SCREEN LAYOUT
    // --------------------------------------------------

    final gameAreaHeight = size.y * 0.48;

    final topBoxPosition = Vector2(4, 4);

    final topBoxSize = Vector2(size.x - 8, gameAreaHeight - 8);

    final bottomBoxPosition = Vector2(4, gameAreaHeight + 4);

    final bottomBoxSize = Vector2(size.x - 8, size.y - gameAreaHeight - 8);

    // --------------------------------------------------
    // TOP BOX
    // --------------------------------------------------

    add(BoxComponent(position: topBoxPosition, size: topBoxSize));

    // --------------------------------------------------
    // BOTTOM BOX
    // --------------------------------------------------

    add(BoxComponent(position: bottomBoxPosition, size: bottomBoxSize));

    // --------------------------------------------------
    // PLAYER
    // --------------------------------------------------

    final playerPosition = Vector2(size.x / 2, gameAreaHeight / 2);

    add(PlayerComponent(sprite: Sprite(playerImage), position: playerPosition));

    // --------------------------------------------------
    // ENEMY
    // --------------------------------------------------

    spawnEnemy(Sprite(enemyImage), playerPosition, gameAreaHeight);

    // --------------------------------------------------
    // BUTTON
    // --------------------------------------------------

    final buttonWidth = bottomBoxSize.x * 0.32;
    final buttonHeight = buttonWidth / 3;

    add(
      PlusOne(
        game: this,
        icon: Sprite(plusOneIconImage),
        size: Vector2(buttonWidth, buttonHeight),
        position: Vector2(
          bottomBoxPosition.x + bottomBoxSize.x / 2,
          bottomBoxPosition.y + bottomBoxSize.y / 6,
        ),
        anchor: Anchor.center,
      ),
    );
  }

  void spawnEnemy(Sprite sprite, Vector2 target, double gameAreaHeight) {
    final random = Random();

    final side = random.nextInt(4);

    late Vector2 spawnPosition;

    switch (side) {
      case 0:
        // Top
        spawnPosition = Vector2(random.nextDouble() * size.x, -40);
        break;

      case 1:
        // Bottom
        spawnPosition = Vector2(
          random.nextDouble() * size.x,
          gameAreaHeight + 40,
        );
        break;

      case 2:
        // Left
        spawnPosition = Vector2(-40, random.nextDouble() * gameAreaHeight);
        break;

      default:
        // Right
        spawnPosition = Vector2(
          size.x + 40,
          random.nextDouble() * gameAreaHeight,
        );
        break;
    }

    final enemy = EnemyComponent(
      sprite: sprite,
      target: target,
      spawnPosition: spawnPosition,
    );

    add(enemy);
  }
}
