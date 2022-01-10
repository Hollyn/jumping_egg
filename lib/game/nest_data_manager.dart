import 'dart:math';

import 'package:flame/components.dart';
import 'package:jumping_egg/game/nest_data.dart';

const width = 100.0;
const height = 50.0;

class NestDataManager {
  final List<NestData> _nestDataList = [
    NestData(direction: Vector2(0.0, 1.0), speed: 30),
    NestData(direction: Vector2(1.0, 1.0), speed: 30),
    NestData(direction: Vector2(1.0, 0.0), speed: 30),
    NestData(direction: Vector2(0.0, 0.0), speed: 0),
  ];

  NestData getRandomNestData() {
    return _nestDataList[Random().nextInt(_nestDataList.length)];
  }
}
