import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/game/basket_manager.dart';
import 'package:jumping_egg/game/coin_manager.dart';
import 'package:jumping_egg/game/game_text.dart';
import 'package:jumping_egg/game/nest.dart';
import 'package:jumping_egg/game/nest_data_manager.dart';
import 'package:jumping_egg/game/player.dart';
import 'package:jumping_egg/game/sound_player_component.dart';
import 'package:jumping_egg/helpers/constant.dart';
import 'package:jumping_egg/overlays/game_over_menu.dart';
import 'package:jumping_egg/overlays/pause_menu.dart';
import 'package:jumping_egg/overlays/sound_pause_buttons.dart';

// const width = 128.0;
// const height = 128.0;
const width = 100.0;
const height = 50.0;
const gravity = 400.0;
const boost = -450.0;

late ParallaxComponent parallaxComponent;
NestDataManager nestDataManager = NestDataManager();
late TextComponent health;
late TextComponent score;
late TextComponent coin;

class JumpingEgg extends FlameGame with TapDetector, HasCollidables {
  final ScoreController scoreController;
  JumpingEgg({required this.scoreController});

  late Player player;
  List<Nest> nests = [];
  int nestNumber = 0;
  int nestNumber2 = 0;
  bool goingToNextLevel = false;
  bool goingToNextLevel2 = false;
  late BasketManager basketManager;
  late CoinManager coinManager;
  late SoundPlayerComponent soundPlayerComponent;

  List<ParallaxImageData> imagesParallax = [
    ParallaxImageData('parallax/background.png'),
    ParallaxImageData('parallax/left_branch.png'),
    ParallaxImageData('parallax/right_branch.png'),
  ];

  @override
  Future<void>? onLoad() async {
    await Flame.device.fullScreen();

    // load player's sprite
    await images.loadAll([
      'sprites/egg.png',
      'sprites/basket.png',
    ]);
    parallaxComponent = await loadParallaxComponent(
      imagesParallax,
      baseVelocity: Vector2.zero(),
      velocityMultiplierDelta: Vector2(1.8, 1.0),
      repeat: ImageRepeat.repeatY,
    );
    add(parallaxComponent);

    coinManager = CoinManager(
      sprite: Sprite(images.fromCache('sprites/egg.png')),
      gameRef: this,
    );
    add(coinManager);

    soundPlayerComponent = SoundPlayerComponent(gameRef: this);
    add(soundPlayerComponent);

    basketManager =
        BasketManager(sprite: Sprite(images.fromCache('sprites/basket.png')));
    add(basketManager);

    // create player
    player = Player(
      sprite: Sprite(images.fromCache('sprites/egg.png')),
      size: Vector2(kSpriteSize, kSpriteSize),
      position: basketManager.getBasketAt(nestNumber2).position,
      priority: 0,
      initCoin: scoreController.getHighestScore(),
      gameRef: this,
    );

    health = GameText(
      text: 'Health : 6',
      anchor: Anchor.topRight,
      position: Vector2(size.x - 10, 10),
    );

    score = GameText(
      text: 'Score : 0',
      anchor: Anchor.topLeft,
      position: Vector2(10, 10),
    );

    coin = GameText(
      text: 'Coin : 0',
      anchor: Anchor.bottomLeft,
      position: Vector2(10, size.y - 10),
    );

    add(score);
    add(health);
    add(coin);
    add(player);

    return super.onLoad();
  }

  @override
  void onAttach() {
    super.onAttach();
    if (scoreController.getPlayerData().music) {
      soundPlayerComponent.playBGM();
    }
  }

  @override
  void onDetach() {
    super.onDetach();
    soundPlayerComponent.stopBGM();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // update score and health
    score.text = 'Score : ${player.getCurrentScore()}';
    health.text = 'Health : ${player.getCurrentHealth()}';
    coin.text = 'Coin : ${player.getCurrentCoin()}';

    // if player dies, reset to the last position
    if (player.isDead()) {
      player.position = basketManager
          .getBasketAt(player.getCurrentRelativePosition())
          .position;
      player.reset();
      // decrease life
      player.decreaseHealth();

      if (player.getCurrentHealth() == 0) {
        health.text = 'Health : 0';
        overlays.remove(SoundPauseButtons.ID);
        overlays.add(GameOverMenu.ID);
        pauseEngine();
      }
      return;
    }

    // landing on a basket
    if (player.getSpeedY() > 0 &&
            player.bottom >
                basketManager
                    .getBasketAt(player.getNextRelativePosition())
                    .top &&
            player.bottom <=
                basketManager
                    .getBasketAt(player.getNextRelativePosition())
                    .bottom
        // &&
        // player.left >= basketManager.getBasketAt(nestNumber + 1).left + 5 &&
        // player.right <= basketManager.getBasketAt(nestNumber + 1).right - 5
        ) {
      if (scoreController.getPlayerData().soundEffect) {
        soundPlayerComponent.playSound('landing.mp3');
      }
      player.updateRelativePosition();
      player.reset();
      player.increaseScore();
      scoreController.setHighestScore(player.getCurrentScore());

      if (player.isInTopRelativePosition()) {
        goToNextLevel(value: true);
      }
    }

    if (player.isStop()) {
      player.position = basketManager
          .getBasketAt(player.getCurrentRelativePosition())
          .position
          .clone();
    }

    if (goingToNextLevel2) {
      player.setRelativePosition(player.getTopRelativePosition() -
          basketManager.getNumberOfBasketDisposed());
      if (basketManager.getNumberOfBasketDisposed() ==
          player.getTopRelativePosition()) {
        goToNextLevel(value: false);
      }
    }
  }

  void goToNextLevel({required bool value}) {
    goingToNextLevel2 = value;
    basketManager.goToNextLevel(value);
    toggleParallax(value);
  }

  @override
  void onTap() {
    if (!paused) {
      player.jump();
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        soundPlayerComponent.playBGM();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        soundPlayerComponent.stopBGM();
        if (player.getCurrentHealth() > 0) {
          pauseEngine();
          overlays.remove(SoundPauseButtons.ID);
          overlays.add(PauseMenu.ID);
        }
        break;
    }
  }

  void addCoinToUserData() {
    scoreController.addCoin();
  }

  void toggleParallax(bool move) {
    if (move == true) {
      parallaxComponent.parallax?.baseVelocity = Vector2(0, -300);
    } else {
      parallaxComponent.parallax?.baseVelocity = Vector2.zero();
    }
  }

  void resetGame() {
    basketManager.resetData();
    player.resetData();
  }

  void playBackgroundMusic() {
    if (scoreController.getPlayerData().music) {
      soundPlayerComponent.playBGM();
    } else {
      soundPlayerComponent.stopBGM();
    }
  }
}
