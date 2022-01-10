import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
// import 'package:flame/parallax.dart';
// import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:jumping_egg/game/background.dart';
import 'package:jumping_egg/game/nest.dart';
import 'package:jumping_egg/game/nest_data_manager.dart';
import 'package:jumping_egg/game/player.dart';

const width = 100.0;
const height = 50.0;
const gravity = 400.0;
const boost = -450.0;
NestDataManager nestDataManager = NestDataManager();

TextPaint textPaint = TextPaint(
  style: const TextStyle(
    fontSize: 48.0,
    fontFamily: 'Awesome Font',
  ),
);

class JumpingEgg extends FlameGame with TapDetector {
  late Player player;
  List<Nest> nests = [];
  int nestNumber = 0;
  bool goingToNextLevel = false;

  @override
  Future<void>? onLoad() async {
    await super.onLoad();

    // load player's sprite
    await images.load('egg.png');
    await images.load('nest.png');

    // add background in the game
    add(Background());

    // create nests
    // nestManager = NestManager(sprite: nestSprite);

    // background music
    // FlameAudio.bgm.initialize();

    // play background music
    // FlameAudio.bgm.play('background_music.mp3');

    // create 5 nests
    addNestsInTheGame(3);

    // create player
    player = Player(
      sprite: Sprite(images.fromCache('egg.png')),
      size: Vector2(height, height),
      position: nests[nestNumber].position,
      priority: 1,
    );

    // add player
    add(player);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // if player dies, reset to the last position
    if (player.isDead()) {
      player.position = nests[nestNumber].position;
      player.reset();
      return;
    }

    // landing on a nest
    if (player.getSpeedY() > 0 &&
        player.bottom >= nests[nestNumber + 1].y &&
        player.bottom <= nests[nestNumber + 1].bottom &&
        player.left >= nests[nestNumber + 1].left + 5 &&
        player.right <= nests[nestNumber + 1].right - 5) {
      nestNumber++;
      player.reset();

      if (nestNumber == 2) {
        // add nests
        addNestsInTheGame(2);

        moveNestsDown(value: true);
      }
    }

    if (player.getSpeedY() == 0) {
      player.position = nests[nestNumber].position.clone();
    }
    if (goingToNextLevel) {
      if (nests[2].initPosition.y >= ((size.y / 4) * 3)) {
        moveNestsDown(value: false);
        nestNumber = 0;
      }
    }
  }

  void moveNestsDown({required bool value}) {
    goingToNextLevel = value;
    for (var i = 0; i < nests.length; i++) {
      nests[i].goDown(value: value);
    }

    if (!value) {
      // remove the 2 first nests and add 2 nests at the tail

      final Nest nest = nests[2];

      remove(nests[0]);
      remove(nests[1]);
      nests.removeAt(0);
      nests.removeAt(1);

      nests[0] = nest;
    }
  }

  void addNestsInTheGame(int numberOfNest) {
    bool init = false;
    if (nests.isEmpty) {
      init = true;
    }
    for (var i = numberOfNest - 1; i >= 0; i--) {
      final randomNestData = nestDataManager.getRandomNestData();
      final Nest nest = Nest(
        sprite: Sprite(images.fromCache('nest.png')),
        size: Vector2(width, height),
        position: init
            ? Vector2(size.x / 2, (size.y / 4) * (i + 1))
            : Vector2(size.x / 2, (size.y / 4) * (i - 1)),
        direction: randomNestData.getDirection(),
        speed: randomNestData.getSpeed(),
      );
      nests.add(nest);
      add(nest);
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    // textPaint.render(canvas, nests.length.toString(), Vector2(10, 10));
  }

  @override
  void onTap() {
    player.jump();
  }
}
