import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/helpers/constant.dart';

import 'coin.dart';

bool _isCollectCoin = false;

late HitboxCircle shape;
int timeLastCoinCollected = DateTime.now().microsecondsSinceEpoch;

class Player extends SpriteComponent with HasHitboxes, Collidable {
  double _speedY = 0.0;
  bool _stop = true;
  bool _dead = false;
  bool _canJump = true;
  int _relativePosition = kStartRelativePosition;
  int _score = kStartScore;
  int _health = kStartHealth;
  late int _coin;
  final int _topRelativePosition = kTopRelativePosition;
  final JumpingEgg gameRef;

  Player({
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
    int? priority,
    int? initCoin,
    Anchor? anchor,
    required this.gameRef,
  }) : super(
          position: position,
          size: size,
          sprite: sprite,
          priority: priority,
          anchor: anchor,
        ) {
    // anchor = Anchor(0.5, 0.7);

    shape = HitboxCircle(normalizedRadius: .5);
    addHitbox(shape);
    if (initCoin != null) {
      _coin = initCoin;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Coin) {
      _isCollectCoin = true;
    }
    // print(DateTime.now().microsecondsSinceEpoch);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_isCollectCoin) {
      if (gameRef.scoreController.getPlayerData().soundEffect) {
        gameRef.soundPlayerComponent.playSound('collect_coin.wav');
      }
      if (DateTime.now().microsecondsSinceEpoch - timeLastCoinCollected >
          1000000) {
        print(DateTime.now().microsecondsSinceEpoch - timeLastCoinCollected);
        gameRef.addCoinToUserData(_coin++);
      }

      _isCollectCoin = false;
      timeLastCoinCollected = DateTime.now().microsecondsSinceEpoch;
    }

    super.update(dt);
    if (_stop) {
      return;
    }

    y += _speedY * dt - kPlayerGravity * dt * dt / 2;
    _speedY += kPlayerGravity * dt;

    if (y > gameRef.size.y + kEggSize) {
      if (gameRef.scoreController.getPlayerData().soundEffect) {
        // gameRef.soundPlayerComponent.playSound('fall.wav');
      }
      _dead = true;
    }
  }

  void reset() {
    _speedY = 0.0;
    _stop = true;
    _dead = false;
    _canJump = true;
  }

  void jump() {
    if (_stop) {
      _stop = false;
    }
    if (_canJump) {
      _speedY = kPlayerBoost;
      if (gameRef.scoreController.getPlayerData().soundEffect) {
        gameRef.soundPlayerComponent.playSound('jump.mp3');
      }
    }
    _canJump = false;
  }

  bool isDead() {
    return _dead;
  }

  double getSpeedY() {
    return _speedY;
  }

  double get top {
    return y - height / 2;
  }

  double get bottom {
    return y + height / 2;
  }

  double get left {
    return x - width / 2;
  }

  double get right {
    return x + width / 2;
  }

  int getCurrentRelativePosition() {
    return _relativePosition;
  }

  void updateRelativePosition() {
    _relativePosition++;
  }

  int getNextRelativePosition() {
    return _relativePosition + 1;
  }

  void setRelativePosition(int position) {
    _relativePosition = position;
  }

  void resetRelativePosition() {
    _relativePosition = 0;
  }

  bool isInTopRelativePosition() {
    return _relativePosition == _topRelativePosition;
  }

  bool isStop() {
    return _speedY == 0;
  }

  int getTopRelativePosition() {
    return _topRelativePosition;
  }

  int getCurrentHealth() {
    return _health;
  }

  void decreaseHealth() {
    _health--;
    if (_health <= 0) {
      _health = 0;
    }
  }

  void increaseHealth() {
    _health++;
  }

  int getCurrentScore() {
    return _score;
  }

  void increaseScore() {
    _score++;
  }

  void resetData() {
    _score = kStartScore;
    _health = kStartHealth;
    _relativePosition = kStartRelativePosition;
  }

  int getCurrentCoin() {
    return _coin;
  }

  void setCurrentCoin(int value) {
    _coin = value;
  }

  // final Paint hitboxPaint = BasicPalette.red.paint()
  //   ..style = PaintingStyle.stroke;
  // final Paint dotPaint = BasicPalette.red.paint()..style = PaintingStyle.stroke;
  //
  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   shape.render(canvas, hitboxPaint);
  // }
}
