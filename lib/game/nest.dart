import 'package:flame/components.dart';
import 'package:flutter/cupertino.dart';

double speedY = 0.0;
const gravity = 300.0;
const boost = -450.0;

class Nest extends SpriteComponent with HasGameRef {
  bool canBeLandedOn = false;
  double speedY = 600.0;
  bool _isGoingDown = false;
  Vector2? _direction;
  // double? _speed;
  late Vector2 initPosition;

  Nest({
    required Sprite sprite,
    Vector2? size,
    required Vector2 position,
    Paint? paint,
    int? priority,
    Vector2? direction,
    double? speed,
  }) : super(
          position: position,
          size: size,
          sprite: sprite,
          paint: paint,
          priority: priority,
        ) {
    anchor = Anchor.center;
    _direction = direction;
    // _speed = speed;
    initPosition = position;
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

  @override
  void update(double dt) {
    super.update(dt);

    // direction and speed
    if (_direction != null) {
      position = position + _direction!;

      // clamp left and right
      if (position.y >= initPosition.y + 50 ||
          position.y <= initPosition.y - 50 ||
          position.x >= initPosition.x + 50 ||
          position.x <= initPosition.x - 50) {
        _direction!.multiply(Vector2(-1, -1));
      }

      // move down
      if (!_isGoingDown) {
        return;
      }

      y += speedY * dt;
      initPosition.y += speedY * dt;
      speedY += gravity * dt;
    }
  }

  void goDown({required bool value}) {
    _isGoingDown = value;
    speedY = 0.0;
  }
}
