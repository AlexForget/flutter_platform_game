import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/painting.dart';
import 'package:platfom_game/components/jump_button.dart';
import 'package:platfom_game/components/player.dart';
import 'package:platfom_game/components/level.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  @override
  Color backgroundColor() => const Color(0xff211f30);
  late CameraComponent cam;
  Player player = Player(character: 'Mask Dude');
  late JoystickComponent joystick;
  bool showControls = true;
  List<String> levelNames = ['level-01.tmx', 'level-02.tmx'];
  int currentLevelIndex = 1;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    _loadLevel();

    if (showControls) {
      addJoystick();
      add(JumpButton());
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  // Adding joystick with included component
  void addJoystick() {
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

    // Adding joystick with image png
    // joystick = JoystickComponent(
    //   knob: SpriteComponent(
    //     sprite: Sprite(
    //       images.fromCache('HUD/Knob.png'),
    //     ),
    //   ),
    //   background: SpriteComponent(
    //     sprite: Sprite(
    //       images.fromCache('HUD/Joystick.png'),
    //     ),
    //   ),
    //   margin: const EdgeInsets.only(left: 32, bottom: 32),
    // );
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.upLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
        player.horizontalMovement = 1;
        break;
      case JoystickDirection.upRight:
        player.horizontalMovement = 1;
        break;
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      _loadLevel();
    } else {
      // no more level
    }
  }

  void _loadLevel() {
    Future.delayed(const Duration(seconds: 1), () {
      Level world = Level(
        player: player,
        levelName: levelNames[currentLevelIndex],
      );

      cam = CameraComponent.withFixedResolution(
        world: world,
        width: 640,
        height: 360,
      );
      cam.priority = 0;
      cam.viewfinder.anchor = Anchor.topLeft;

      addAll([cam, world]);
    });
  }
}
