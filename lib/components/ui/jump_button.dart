import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:platfom_game/pixel_adventure.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<PixelAdventure>, TapCallbacks {
  JumpButton();

  final margin = 20;
  final buttonSize = 64;

  @override
  FutureOr<void> onLoad() {
    priority = 10;
    sprite = Sprite(game.images.fromCache(
        'HUD/JumpButton.png')); // /home/alexandreqc26/Projets/Flutter/flutter_platform_game/assets/images/HUD/JumpButton.png
    position = Vector2(
      game.size.x - margin - buttonSize,
      game.size.y - margin - buttonSize,
    );

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.isJumping = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.isJumping = false;
    super.onTapUp(event);
  }
}
