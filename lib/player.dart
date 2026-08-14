import 'package:flame/components.dart';
import 'package:flame/collisions.dart';

class PlayerComponent extends SpriteComponent with CollisionCallbacks {
  PlayerComponent({required super.sprite, required Vector2 position})
    : super(size: Vector2(50, 50), position: position, anchor: Anchor.center);
}
