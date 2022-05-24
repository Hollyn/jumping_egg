import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/game/basket.dart';
import 'package:jumping_egg/game/basket_container.dart';
import 'package:jumping_egg/game/basket_data_manager.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/helpers/constant.dart';

class BasketManager extends Component with HasGameRef<JumpingEgg> {
  final Sprite sprite;
  late List<BasketContainer> basketContainerList = [];
  int _numberOfBasketDisposed = 0;
  BasketDataManager basketDataManager = BasketDataManager();
  List<Color> colorList = [
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.grey,
    Colors.purple,
    Colors.orange,
    Colors.cyan,
  ];

  int colorPosition = 0;

  BasketManager({required this.sprite}) : super();

  @override
  Future<void> onLoad() async {
    init();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  void init() {
    for (var i = 0; i < 3; i++) {
      addBasketContainer(
          position: Vector2(
            gameRef.size.x / 2,
            (3 - i) * gameRef.size.y / 4,
          ),
          falling: false);
    }
  }

  void addBasketContainer({
    required Vector2 position,
    required bool falling,
  }) {
    final BasketContainer basketContainer = BasketContainer(
      sprite: sprite,
      size: kBasketContainerSize,
      anchor: Anchor.center,
      position: position,
      priority: 1,
      isFalling: falling,
      velocity: basketDataManager.getRandomBasketData().getDirection(),
      color: colorList[colorPosition++ % colorList.length],
    );

    basketContainerList.add(basketContainer);
    add(basketContainer);
  }

  BasketContainer getBasketContainerAt(int position) {
    return basketContainerList[position];
  }

  @override
  void update(double dt) {
    super.update(dt);
    // print('${(gameRef.size.y / 4) * 3} ${getBasketContainerAt(2).position.y}');
    if (getBasketContainerAt(2).position.y >= (gameRef.size.y / 4) * 3) {
      goToNextLevel(false);
    }
    // print('middle basket x = ${basketContainerList[1].position.x}');
    if (
        // children.isNotEmpty &&
        basketContainerList[0].position.y > gameRef.size.y) {
      remove(basketContainerList[0]);
      basketContainerList.removeAt(0);
      _numberOfBasketDisposed++; // update number of basket disposed

      // if (_numberOfBasketDisposed == 2) {
      //   goToNextLevel(false);
      // }
      print('disposed $_numberOfBasketDisposed');
      // addBasket(position: Vector2(gameRef.size.x / 2, 0), falling: true);
    } else {
      // goToNextLevel(false);
    }
  }

  void goToNextLevel(bool value) {
    for (var i = 0; i < basketContainerList.length; i++) {
      // print('i = $i');
      basketContainerList[i].isFalling = value;
    }
    if (value) {
      print('children before = ${children.length}');
      // if (basketContainerList.length < 4) {
      // add 2 basket container
      for (double i = 0; i < 2; i++) {
        addBasketContainer(
          position: Vector2(gameRef.size.x / 2, ((gameRef.size.y / 4) * -i)),
          falling: true,
        );
        // }
      }
    } else {
      // children.remove(basketContainerList[0]);
      // children.remove(basketContainerList[0]);
      // children.remove(basketContainerList[1]);
      // children.remove(basketContainerList[1]);
      // basketContainerList.removeAt(0);
      // basketContainerList.removeAt(1);

      print(basketContainerList.length);
      print('children = ${children.length}');
      _numberOfBasketDisposed = 0;
    }
  }

  int getNumberOfBasketDisposed() {
    return _numberOfBasketDisposed;
  }

  void resetData() {
    // empty basket list
    basketContainerList = [];

    // remove all basket
    for (var child in children) {
      remove(child);
    }

    // init
    init();
  }
}
