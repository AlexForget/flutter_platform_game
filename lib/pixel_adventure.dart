import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/painting.dart';
import 'package:platfom_game/components/ui/jump_button.dart';
import 'package:platfom_game/components/ui/left_button.dart';
import 'package:platfom_game/components/actors/player.dart';
import 'package:platfom_game/components/level_elements/level.dart';
import 'package:platfom_game/components/ui/right_button.dart';

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
  ];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();
    await FlameAudio.audioCache.load('music.wav');
    FlameAudio.bgm.initialize();

    if (playSounds) {
      FlameAudio.bgm.play(
        'music2.wav',
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
        width: 800, // 640
        height: 450, // 360
      );
      cam.priority = 0;
      cam.viewfinder.anchor = Anchor.topLeft;

      addAll([cam, world]);
    });
  }
}
