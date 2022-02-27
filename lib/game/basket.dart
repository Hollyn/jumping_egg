import 'package:flame/components.dart';
import 'package:jumping_egg/helpers/constant.dart';

class Basket extends SpriteComponent with HasGameRef {
  bool isFalling = false;
  Vector2 _velocity = Vector2.zero();
  final PositionComponent parent;
  Basket(
    PositionComponent this.parent, {
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
      _velocity = direction;
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

  Vector2 get velocity => _velocity;

  @override
  void update(double dt) {
    if (isFalling) {
      position += Vector2(0, 1) * kSpeedY * dt;
    } else {
      position += _velocity * kSpeedBasket * dt;
      if ((position.y >= parent.size.y && _velocity.y > 0) ||
          (position.y <= 0 && _velocity.y < 0) ||
          (position.x >= parent.size.x && _velocity.x > 0) ||
          (position.x <= 0 && _velocity.x < 0)) {
        _velocity.negate();
      }
    }
  }

  @override
  void onRemove() {
    super.onRemove();
  }

  void clampUpAndDown() {}
}
