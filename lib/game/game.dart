import 'dart:convert';

import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/cupertino.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/game/basket_container.dart';
import 'package:jumping_egg/game/basket_manager.dart';
import 'package:jumping_egg/game/coin_manager.dart';
import 'package:jumping_egg/game/game_text.dart';
import 'package:jumping_egg/game/nest.dart';
import 'package:jumping_egg/game/nest_data_manager.dart';
import 'package:jumping_egg/game/player.dart';
// import 'package:jumping_egg/game/sound_player_component.dart';
import 'package:jumping_egg/helpers/constant.dart';
import 'package:jumping_egg/main.dart';
import 'package:jumping_egg/models/multiplayer_game_data.dart';
import 'package:jumping_egg/overlays/game_over_menu.dart';
import 'package:jumping_egg/overlays/pause_menu.dart';
import 'package:jumping_egg/overlays/sound_pause_buttons.dart';

import '../overlays/game_over_multiplayer.dart';

late ParallaxComponent parallaxComponent;
NestDataManager nestDataManager = NestDataManager();
late TextComponent health;
late TextComponent score;
late TextComponent scorePlayer2;
late TextComponent infoPlayer2;
late TextComponent coin;

class JumpingEgg extends FlameGame with TapDetector, HasCollidables {
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  bool isMultiPlayer;
  JumpingEgg({
    required this.scoreController,
    required this.isMultiPlayer,
    required this.multiplayerGameData,
  });

  late Player player;
  List<Nest> nests = [];
  int nestNumber = 0;
  int nestNumber2 = 0;
  bool goingToNextLevel = false;
  late BasketManager basketManager;
  late CoinManager coinManager;
  // late SoundPlayerComponent soundPlayerComponent;

  List<ParallaxImageData> imagesParallax = [
    ParallaxImageData('parallax/background.png'),
    ParallaxImageData('parallax/left_branch.png'),
    ParallaxImageData('parallax/right_branch.png'),
  ];

  @override
  Future<void>? onLoad() async {
    await Flame.device.fullScreen();

    camera.viewport = FixedResolutionViewport(kGameResolution);
    camera.setRelativeOffset(Anchor.topLeft);
    camera.speed = 1;

    // load player's sprite
    await images.loadAll([
      'sprites/egg.png',
      'sprites/basket.png',
      'sprites/coin.png',
      'bg_component/basketBg.png',
      'bg_component/coinBg.png',
      'bg_component/healthBg.png',
      'bg_component/guestBg.png',
      'bg_component/hostBg.png',
    ]);
    parallaxComponent = await loadParallaxComponent(
      imagesParallax,
      baseVelocity: Vector2.zero(),
      velocityMultiplierDelta: Vector2(1.2, 1.1),
      repeat: ImageRepeat.repeatY,
    );
    add(parallaxComponent);

    add(
      SpriteComponent()
        ..sprite = Sprite(
          images.fromCache('bg_component/basketBg.png'),
        )
        ..size = Vector2(kBgComponentWidth, kBgComponentHeight)
        ..position = Vector2(kBgComponentMargin, kBgComponentMargin)
        ..anchor = Anchor.topLeft,
    );
    if (isMultiPlayer) {
      if (serverClientController.isClientRunning) {
        add(
          SpriteComponent()
            ..sprite = Sprite(
              images.fromCache('bg_component/hostBg.png'),
            )
            ..size = Vector2(kBgComponentWidth, kBgComponentHeight)
            ..position = Vector2(
              kBgComponentMargin,
              kBgComponentHeight + kBgComponentMargin,
            )
            ..anchor = Anchor.topLeft,
        );
      } else {
        add(
          SpriteComponent()
            ..sprite = Sprite(
              images.fromCache('bg_component/guestBg.png'),
            )
            ..size = Vector2(kBgComponentWidth, kBgComponentHeight)
            ..position = Vector2(
                kBgComponentMargin, kBgComponentHeight + kBgComponentMargin)
            ..anchor = Anchor.topLeft,
        );
      }

      scorePlayer2 = GameText(
        text: (serverClientController.isClientRunning) ? '0' : '0',
        anchor: Anchor.topLeft,
        position: Vector2(
          (kBgComponentWidth / 2) + kTextMargin + kBgComponentMargin + 2,
          kBgComponentHeight * 1.5 + kTextMargin - 8,
        ),
      );
      add(scorePlayer2);

      infoPlayer2 = GameText(
        text: '',
        anchor: Anchor.topLeft,
        position: Vector2(
          kTextMargin + kBgComponentMargin + 12,
          kBgComponentHeight * 2 + kTextMargin + 10,
        ),
      );

      add(infoPlayer2);
    } else {
      add(
        SpriteComponent()
          ..sprite = Sprite(
            images.fromCache('bg_component/healthBg.png'),
          )
          ..size = Vector2(kBgComponentWidth, kBgComponentHeight)
          ..position = Vector2(size.x - kBgComponentMargin, kBgComponentMargin)
          ..anchor = Anchor.topRight,
      );
      add(
        SpriteComponent()
          ..sprite = Sprite(
            images.fromCache('bg_component/coinBg.png'),
          )
          ..size = Vector2(kBgComponentWidth, kBgComponentHeight)
          ..position = Vector2(kBgComponentMargin, size.y - kBgComponentMargin)
          ..anchor = Anchor.bottomLeft,
      );
      coinManager = CoinManager(
        sprite: Sprite(images.fromCache('sprites/coin.png')),
        gameRef: this,
      );
      add(coinManager);

      health = GameText(
        text: kStartHealth.toString(),
        anchor: Anchor.topRight,
        position: Vector2(
          size.x - (kBgComponentWidth / 2) - kBgComponentMargin - kTextMargin,
          (kBgComponentHeight / 2) + kTextMargin - 10,
        ),
      );

      coin = GameText(
        text: '',
        anchor: Anchor.bottomLeft,
        position: Vector2(
          kBgComponentWidth / 2 + kBgComponentMargin + kTextMargin + 1,
          size.y - kBgComponentHeight / 2 + kTextMargin + 13,
        ),
      );

      add(health);
      add(coin);
    }

    // soundPlayerComponent = SoundPlayerComponent(gameRef: this);
    // add(soundPlayerComponent);

    basketManager =
        BasketManager(sprite: Sprite(images.fromCache('sprites/basket.png')));
    add(basketManager);

    // create player
    player = Player(
      sprite: Sprite(images.fromCache('sprites/egg.png')),
      size: Vector2(kEggSize, kEggSize),
      position: basketManager.getBasketContainerAt(0).position,
      priority: 0,
      initCoin: scoreController.getCoin(),
      gameRef: this,
      anchor: Anchor(0.5, 0.7),
    );

    score = GameText(
      text: kStartScore.toString(),
      anchor: Anchor.topLeft,
      position: Vector2(
        kBgComponentWidth / 2 + kBgComponentMargin + kTextMargin + 2,
        kBgComponentHeight / 2 + kTextMargin - 8,
      ),
    );

    add(score);
    add(player);

    return super.onLoad();
  }

  @override
  void onAttach() {
    super.onAttach();
    if (scoreController.getPlayerData().music) {
      // soundPlayerComponent.playBGM();
    }
  }

  @override
  void onDetach() {
    super.onDetach();
    // soundPlayerComponent.stopBGM();
  }

  @override
  void update(double dt) {
    super.update(dt);

    // update score and health
    score.text = '${player.getCurrentScore()}';
    if (isMultiPlayer) {
      if (serverClientController.isClientRunning) {
        scorePlayer2.text = '${multiplayerGameData.hostScore}';
      } else {
        scorePlayer2.text = '${multiplayerGameData.guestScore}';
      }

      if (serverClientController.isClientRunning &&
          multiplayerGameData.hostDied == true) {
        infoPlayer2.text = 'Host died';
      }
      if (serverClientController.isServerRunning &&
          multiplayerGameData.guestDied == true) {
        infoPlayer2.text = 'Guest died';
      }
    } else {
      health.text = '${player.getCurrentHealth()}';
      coin.text = '${player.getCurrentCoin()}';
    }

    // if player dies, reset to the last position
    if (player.isDead()) {
      if (isMultiPlayer) {
        gameOverMultiplayer();
      }
      // decrease life
      player.decreaseHealth();

      if (player.getCurrentHealth() == 0 && !isMultiPlayer) {
        health.text = ' 0';
        overlays.remove(SoundPauseButtons.ID);
        overlays.add(GameOverMenu.ID);
        pauseEngine();
      } else {
        player.position =
            positionBasketInGame(player.getCurrentRelativePosition());
      }
      player.reset();
      return;
    }

    // going down
    if (player.getSpeedY() > 0) {
      // landing on a basket
      if (player.bottom >
              positionBasketInGame(player.getNextRelativePosition()).y &&
          player.bottom <=
              positionBasketInGame(player.getNextRelativePosition()).y +
                  kSpriteSize / 4 &&
          player.left >=
              positionBasketInGame(player.getNextRelativePosition()).x -
                  kSpriteSize / 2 &&
          player.right <=
              positionBasketInGame(player.getNextRelativePosition()).x +
                  kSpriteSize / 2) {
        if (scoreController.getPlayerData().soundEffect) {
          // soundPlayerComponent.playSound('landing.mp3');
        }
        player.updateRelativePosition();
        player.reset();
        player.increaseScore();
        scoreController.setHighestScore(player.getCurrentScore());

        if (isMultiPlayer) {
          String clientName = serverClientController.clientName;
          // print(clientName);
          if (serverClientController.isServerRunning) {
            multiplayerGameData.hostScore = player.getCurrentScore();
            serverClientController.serverToClient(
              clientName,
              jsonEncode(multiplayerGameData.toJson()),
            );
          } else {
            multiplayerGameData.guestScore = player.getCurrentScore();
            serverClientController.clientToServer(
              jsonEncode(multiplayerGameData.toJson()),
            );
          }
        }
        if (player.isInTopRelativePosition()) {
          goToNextLevel(value: true);
        }
      }
    }

    // player is in a basket
    if (player.isStop()) {
      if (goingToNextLevel) {
        player.position += basketManager
                .getBasketContainerAt(player.getCurrentRelativePosition())
                .basket
                .velocity *
            kSpeedBasket *
            dt;
        player.position += Vector2(0, 1) * kSpeedY * dt;
      } else {
        player.position =
            positionBasketInGame(player.getCurrentRelativePosition());
      }
    }

    if (goingToNextLevel) {
      player.setRelativePosition(
        player.getTopRelativePosition() -
            basketManager.getNumberOfBasketDisposed(),
      );
      if (basketManager.getNumberOfBasketDisposed() ==
          player.getTopRelativePosition()) {
        goToNextLevel(value: false);
      }
    }
  }

  Vector2 positionBasketInGame(int playerRelativePosition) {
    final BasketContainer bC =
        basketManager.getBasketContainerAt(playerRelativePosition);

    return bC.basket.position +
        Vector2(size.x / 2, size.y * (3 - playerRelativePosition) / 4) -
        kBasketContainerSize / 2;
  }

  void goToNextLevel({required bool value}) {
    goingToNextLevel = value;
    basketManager.goToNextLevel(value);
    toggleParallax(value);
  }

  @override
  void onTap() {
    if (!paused) {
      // basketManager.goToNextLevel(true);
      player.jump();
    }
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        // soundPlayerComponent.playBGM();
        break;
      case AppLifecycleState.inactive:
        singlePlayerGameOver();
        break;
      case AppLifecycleState.paused:
        singlePlayerGameOver();
        break;
      case AppLifecycleState.detached:
        singlePlayerGameOver();
        break;
    }
  }

  void singlePlayerGameOver() {
// soundPlayerComponent.stopBGM();
    if (player.getCurrentHealth() > 0) {
      pauseEngine();
      overlays.remove(SoundPauseButtons.ID);
      overlays.add(PauseMenu.ID);
    }
  }

  void addCoinToUserData(int value) {
    scoreController.addCoin(value);
  }

  void toggleParallax(bool move) {
    if (move == true) {
      parallaxComponent.parallax?.baseVelocity = Vector2(0, -kSpeedParallax);
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
      // soundPlayerComponent.playBGM();
    } else {
      // soundPlayerComponent.stopBGM();
    }
  }

  void gameOverMultiplayer() {
    pauseEngine();
    overlays.add(GameOverMultiPlayer.ID);
    if (serverClientController.isServerRunning) {
      multiplayerGameData.hostDied = true;
      serverClientController.serverToClient(
        serverClientController.clientName,
        json.encode(multiplayerGameData.toJson()),
      );
    }

    if (serverClientController.isClientRunning) {
      multiplayerGameData.guestDied = true;
      serverClientController.clientToServer(
        json.encode(multiplayerGameData.toJson()),
      );
    }
  }
}
