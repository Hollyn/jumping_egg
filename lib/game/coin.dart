import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:jumping_egg/game/player.dart';
import 'package:jumping_egg/helpers/constant.dart';

class Coin extends SpriteComponent with HasHitboxes, Collidable, HasGameRef {
  double _speedY = 0.0;
  bool _stop = true;
  int _relativePosition = kStartRelativePosition;
  final int _topRelativePosition = kTopRelativePosition;
  bool removed = true;
  late HitboxCircle shape;
  bool _isHit = false;

  Coin({
    Sprite? sprite,
    Vector2? size,
    Vector2? position,
    int? priority,
  }) : super(
          position: position,
          size: size,
          sprite: sprite,
          priority: priority,
        ) {
    anchor = Anchor.center;
    shape = HitboxCircle(normalizedRadius: .5);
    addHitbox(shape);
  }

  @override
  void onCollision(Set<Vector2> points, Collidable other) {
    if (other is Player) {
      _isHit = true;
    }
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

  @override
  void update(double dt) {
    super.update(dt);

    if (_isHit) {
      removeFromParent();
      return;
    }

    if (_stop) {
      return;
    }
  }

  void reset() {
    _speedY = 0.0;
    _stop = true;
  }

  void jump() {
    if (_stop) {
      _stop = false;
    }
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
}
