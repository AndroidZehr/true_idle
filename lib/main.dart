import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class WindowsComponent extends SpriteComponent with TapCallbacks {
  final TrueIdleGame game;

  WindowsComponent({required this.game, required super.sprite})
    : super(size: Vector2(200, 200), position: Vector2(100, 100));

  @override
  void onTapDown(TapDownEvent event) {
    game.money++;
    print('Money: ${game.money}');
  }
}

class TrueIdleGame extends FlameGame {
  int money = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final image = await images.load('windows.png');

    add(WindowsComponent(game: this, sprite: Sprite(image)));
  }
}

void main() {
  runApp(GameWidget(game: TrueIdleGame()));
}
