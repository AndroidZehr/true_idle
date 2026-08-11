import 'package:flame/components.dart';

class PlayerComponent extends SpriteComponent {
  PlayerComponent({required super.sprite, required Vector2 position})
    : super(size: Vector2(50, 50), position: position);
}
