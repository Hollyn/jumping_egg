import 'dart:math';
import 'package:flame/components.dart';
import 'package:jumping_egg/game/basket_data.dart';

const width = 100.0;
const height = 50.0;

class BasketDataManager {
  final List<BasketData> _nestDataList = [
    BasketData(direction: Vector2(0.0, 100.0), speed: 30),
    BasketData(direction: Vector2(100.0, 100.0), speed: 30),
    BasketData(direction: Vector2(100.0, 0.0), speed: 30),
    BasketData(direction: Vector2(0.0, 0.0), speed: 0),
  ];

  BasketData getRandomBasketData() {
    return _nestDataList[Random().nextInt(_nestDataList.length)];
  }
}
