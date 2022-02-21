import 'package:flame/components.dart';

class BasketData {
  late final Vector2 _direction;
  late final double _speed;

  BasketData({
    required Vector2 direction,
    required double speed,
  }) {
    _direction = direction;
    _speed = speed;
  }

  double getSpeed() {
    return _speed;
  }

  Vector2 getDirection() {
    return _direction;
  }
}
