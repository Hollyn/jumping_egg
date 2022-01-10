import 'package:flame/components.dart';

const double gravity = 800.0;
const double boost = -700.0;

class Player extends SpriteComponent with HasGameRef {
  double _speedY = 0.0;
  bool _stop = true;
  bool _dead = false;
  Player({
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
    anchor = Anchor(0.5, 0.7);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (_stop) {
      return;
    }

    y += _speedY * dt - gravity * dt * dt / 2;
    _speedY += gravity * dt;

    if (y > gameRef.size.y) {
      _dead = true;
    }
  }

  void reset() {
    _speedY = 0.0;
    _stop = true;
    _dead = false;
  }

  void jump() {
    if (_stop) {
      _stop = false;
    }
    _speedY = boost;
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
}
