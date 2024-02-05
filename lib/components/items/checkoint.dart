import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Checkpoint extends SpriteAnimationComponent
    with HasGameRef, CollisionCallbacks {
  Checkpoint({
    super.position,
    super.size,
  }) : super();

  late bool isReachable;

  @override
  FutureOr<void> onLoad() {
    isReachable = false;
    // debugMode = true;
    add(
      RectangleHitbox(
        position: Vector2(18, 16),
        size: Vector2(12, 50),
        collisionType: CollisionType.passive,
      ),
    );

    animation = SpriteAnimation.fromFrameData(
      game.images
          .fromCache('Items/Checkpoints/Checkpoint/Checkpoint (No Flag).png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2.all(64),
      ),
    );
    return super.onLoad();
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    // if (other is Player) allFruitsAreCollected();
    super.onCollisionStart(intersectionPoints, other);
  }

  Future<void> allFruitsAreCollected() async {
    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(
          'Items/Checkpoints/Checkpoint/Checkpoint (Flag Out) (64x64).png'),
      SpriteAnimationData.sequenced(
        amount: 26,
        stepTime: 0.02,
        textureSize: Vector2.all(64),
        loop: false,
      ),
    );

    await animationTicker?.completed;

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(
          'Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png'),
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.05,
        textureSize: Vector2.all(64),
      ),
    );
  }
}
