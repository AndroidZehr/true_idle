import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'true_idle_game.dart';
import 'box.dart';
import 'package:flutter/material.dart';

class PlusOne extends PositionComponent with TapCallbacks {
  final TrueIdleGame game;
  final Sprite icon;
  bool _pressed = false;

  PlusOne({
    required this.game,
    required this.icon,
    required super.size,
    required super.position,
    super.anchor,
  });

  late final BoxComponent _background;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    _background = BoxComponent(
      position: Vector2.zero(),
      size: size,
      color: const Color.fromARGB(255, 99, 203, 255),
    );
    add(_background);

    add(
      SpriteComponent(
        sprite: icon,
        size: Vector2(size.y * 0.6, size.y * 0.6),
        anchor: Anchor.center,
        position: size / 2,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    _pressed = true;
    _background.opacity = 0.7;
    game.money.value++;
  }

  @override
  void onTapUp(TapUpEvent event) {
    _pressed = false;
    _background.opacity = 1.0;
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    _pressed = false;
    _background.opacity = 1.0;
  }
}
