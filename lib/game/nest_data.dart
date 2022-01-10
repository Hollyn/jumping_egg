import 'package:flame/components.dart';

class NestData {
  late final Vector2 _direction;
  late final double _speed;

  NestData({
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
