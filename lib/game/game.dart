import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
// import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jumping_egg/game/player.dart';

import 'nest.dart';

class JumpingEgg extends FlameGame with TapDetector, HasCollidables {
  late Player player;
  late Nest nest;
  late ParallaxComponent background;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    // load player's sprite
    final playerSprite = await loadSprite('egg.png');
    final nestSprite = await loadSprite('nest.png');

    // create player
    player = Player(
      playerSprite,
      50.0,
      50.0,
      size / 2,
      Anchor.center,
    );

    // create player
    nest = Nest(
      sprite: nestSprite,
      size: Vector2(100, 50),
      position: Vector2(size.x / 2, (size.y / 2) + 100),
      anchor: Anchor.center,
    );

    // load background image
    background = await ParallaxComponent.load(
        [ParallaxImageData('background.png')],
        repeat: ImageRepeat.noRepeat);

    // background music
    // FlameAudio.bgm.initialize();

    // play background music
    // FlameAudio.bgm.play('background_music.mp3');

    // add background
    add(background);

    // add nest
    add(nest);

    // add player
    add(player);
  }

  @override
  void onTap() {
    player.jump();
  }
}
