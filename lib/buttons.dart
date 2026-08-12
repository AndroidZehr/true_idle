import 'package:flame/components.dart';
import 'package:flame/events.dart';

import 'true_idle_game.dart';

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
