import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import '../ui.dart';
import '../buttons.dart';
import '../enemies.dart';
import '../player.dart';

class TrueIdleGame extends FlameGame {
  ValueNotifier<int> money = ValueNotifier<int>(0);

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 53, 53, 53);
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load images
    final plusOneImage = await images.load('PlusOne.png');
    final plusOnePressedImage = await images.load('PlusOne_pressed.png');
    final enemyImage = await images.load('Enemy1.png');
    final playerImage = await images.load('Player.png');

    // Calculate the size of the top game area
    final gameAreaHeight = size.y * 0.48;

    // Put the player in the center of the top area
    final playerPosition = Vector2(size.x / 2, gameAreaHeight / 2);

    // Add the money button
    add(
      PlusOne(
        game: this,
        normalSprite: Sprite(plusOneImage),
        pressedSprite: Sprite(plusOnePressedImage),
      ),
    );

    // Add the player
    add(PlayerComponent(sprite: Sprite(playerImage), position: playerPosition));

    // Add an enemy
    spawnEnemy(Sprite(enemyImage), playerPosition, gameAreaHeight);

    // Add top border
    add(
      BorderComponent(
        position: Vector2(4, 4),
        size: Vector2(size.x - 8, gameAreaHeight - 8),
      ),
    );

    // Add bottom border
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
