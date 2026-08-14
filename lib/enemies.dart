import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class EnemyComponent extends SpriteComponent with CollisionCallbacks {
  final Vector2 target;
  final double speed;

  EnemyComponent({
    required super.sprite,
    required this.target,
    required Vector2 spawnPosition,
    this.speed = 50,
  }) : super(
         size: Vector2(32, 32),
         position: spawnPosition,
         anchor: Anchor.center,
       );

  @override
  void update(double dt) {
    super.update(dt);

    final direction = target - position;

    if (direction.length > 0) {
      direction.normalize();

      angle = atan2(-direction.x, direction.y);
      position += direction * speed * dt;
    }
  }
}
