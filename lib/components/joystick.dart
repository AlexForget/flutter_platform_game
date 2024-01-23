import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:platfom_game/pixel_adventure.dart';

class Joystick extends SpriteComponent
    with HasGameRef<PixelAdventure>, TapCallbacks {
  Joystick();

  final margin = 40;
  final buttonSize = 64;
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() {
    joystick = JoystickComponent(
      priority: 10,
      knob: CircleComponent(
        radius: 20,
        paint: BasicPalette.gray.paint(),
      ),
      background: CircleComponent(
        radius: 40,
        paint: BasicPalette.black.withAlpha(100).paint(),
      ),
      margin: const EdgeInsets.only(bottom: 40, left: 40),
    );

    return super.onLoad();
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
        game.player.horizontalMovement = -1;
        break;
      case JoystickDirection.upLeft:
        game.player.horizontalMovement = -1;
        break;
      case JoystickDirection.downLeft:
        game.player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
        game.player.horizontalMovement = 1;
        break;
      case JoystickDirection.upRight:
        game.player.horizontalMovement = 1;
        break;
      case JoystickDirection.downRight:
        game.player.horizontalMovement = 1;
        break;
      default:
        game.player.horizontalMovement = 0;
        break;
    }
  }
}
