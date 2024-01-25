import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/painting.dart';
import 'package:platfom_game/components/jump_button.dart';
import 'package:platfom_game/components/left_button.dart';
import 'package:platfom_game/components/player.dart';
import 'package:platfom_game/components/level.dart';
import 'package:platfom_game/components/right_button.dart';

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
  bool showControls = true;
  bool playSounds = true;
  double soundVolume = 1.0;
  List<String> levelNames = [
    'level-01.tmx',
    'level-02.tmx',
    'level-03.tmx',
    'level-04.tmx',
    'level-05.tmx',
    'level-06.tmx',
    'level-07.tmx',
    'level-08.tmx',
    'level-09.tmx',
    'level-10.tmx',
  ];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    if (playSounds) {
      FlameAudio.bgm.play(
        'music2.mp3',
        volume: soundVolume,
      );
    }

    _loadLevel();

    if (showControls) {
      add(RightButton());
      add(LeftButton());
      add(JumpButton());
    }

    return super.onLoad();
  }

  void loadNextLevel() {
    removeWhere((component) => component is Level);

    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      _loadLevel();
    } else {
      // no more level
      currentLevelIndex = 0;
      _loadLevel();
    }
  }

  void _loadLevel() {
    Future.delayed(const Duration(milliseconds: 500), () {
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
