import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:platfom_game/pixel_adventure.dart';

class RightButton extends SpriteComponent
    with HasGameRef<PixelAdventure>, TapCallbacks {
  RightButton();

  final xMargin = 60.0;
  final yMargin = 40.0;
  final buttonSize = 64;

  @override
  FutureOr<void> onLoad() {
    priority = 10;
    sprite = Sprite(game.images.fromCache(
        'HUD/JumpButton.png')); // /home/alexandreqc26/Projets/Flutter/flutter_platform_game/assets/images/HUD/JumpButton.png
    position = Vector2(
      xMargin + buttonSize,
      game.size.y - yMargin - buttonSize,
    );

    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    game.player.horizontalMovement = 1;
    super.onTapDown(event);
  }

  @override
  void onTapCancel(TapCancelEvent event) {
    game.player.horizontalMovement = 0;
    super.onTapCancel(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    game.player.horizontalMovement = 0;
    super.onTapUp(event);
  }
}
