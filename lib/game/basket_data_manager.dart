import 'dart:math';
import 'package:flame/components.dart';
import 'package:jumping_egg/game/basket_data.dart';

class BasketDataManager {
  int _currentBasketData = 0;
  final List<int> _multiplayerIndices = [
    0,
    1,
    2,
    3,
    3,
    2,
    1,
    0,
    1,
    3,
    0,
    2,
    3,
    1,
    2,
    0,
    3,
    1,
    2,
    3,
    0,
    2,
    1,
  ];

  final List<BasketData> _nestDataList = [
    BasketData(direction: Vector2(0.0, 1.0), speed: 30),
    BasketData(direction: Vector2(1.0, 1.0), speed: 30),
    BasketData(direction: Vector2(1.0, 0.0), speed: 30),
    BasketData(direction: Vector2(0.0, 0.0), speed: 0),
  ];

  BasketData getBasketDataForMultiplayerGame() {
    final BasketData basketData =
        _nestDataList[_multiplayerIndices[_currentBasketData]];
    _currentBasketData++;

    if (_currentBasketData > _multiplayerIndices.length) {
      _currentBasketData = 0;
    }
    return basketData;
  }

  BasketData getRandomBasketData() {
    print("random");
    return _nestDataList[Random().nextInt(_nestDataList.length)];
  }
}
