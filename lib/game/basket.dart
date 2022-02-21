import 'package:flame/components.dart';

class Basket extends SpriteComponent with HasGameRef {
  bool isFalling = false;
  final double _speed = 250.0;
  // Vector2 _velocity = Vector2.zero();
  Basket({
    Sprite? sprite,
    Vector2? size,
    required Vector2 position,
    int? priority,
    Vector2? direction,
    required this.isFalling,
  }) : super(
          position: position,
          size: size,
          sprite: sprite,
          priority: priority,
        ) {
    anchor = Anchor.center;
    if (direction != null) {
      // _velocity = direction;
    }
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
    if (isFalling) {
      position += Vector2(0, 1) * _speed * dt;
    } else {}
    // position += _velocity * dt;
  }

  @override
  void onRemove() {
    super.onRemove();
  }

  void clampUpAndDown() {}
}
