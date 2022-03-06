import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/game/basket.dart';
import 'package:jumping_egg/game/basket_data_manager.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/helpers/constant.dart';

// late HitboxShape shape;

class BasketContainer extends PositionComponent with HasGameRef<JumpingEgg> {
  // , HasHitboxes, Collidable {
  late Basket basket;
  final Sprite sprite;
  late bool _isFalling;
  BasketDataManager basketDataManager = BasketDataManager();
  Vector2 _velocity = Vector2.zero();

  BasketContainer({
    required this.sprite,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
    required bool isFalling,
    required Vector2 velocity,
    Color? color,
  }) : super(
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
        ) {
    _velocity = velocity;
    // shape = HitboxRectangle();
    // addHitbox(shape);
    _isFalling = isFalling;
    if (color != null) {
      debugColor = color;
    }
    init();
  }

  @override
  Future<void> onLoad() async {
    // Only runs once, when the component is loaded.
    // init();
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   var rect = Rect.fromCenter(
  //     center: Offset(position.x, position.y),
  //     width: 150,
  //     height: 150,
  //   );
  //   var rect2 = Rect.largest;
  //   // var rect = Rect.fromLTWH(10.0, 10.0, 100.0, 100.0);
  //   var paint = Paint()..color = Color(0xFFFF0000);
  //   canvas.drawRect(rect, paint);
  // }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    // renderHitboxes(canvas);
  }

  void init() {
    addBasket(
      position: position,
      falling: false,
    );
  }

  void addBasket({
    required Vector2 position,
    required bool falling,
  }) {
    basket = Basket(
      this,
      sprite: sprite,
      size: Vector2(kSpriteSize, kSpriteSize),
      position: size / 2,
      priority: 1,
      isFalling: falling,
      direction: _velocity,
    );

    add(basket);
  }

  // get isFalling() => _isFalling;
  set isFalling(bool value) => _isFalling = value;

  @override
  void update(double dt) {
    super.update(dt);

    if (_isFalling == true) {
      position += Vector2(0, 1) * kSpeedY * dt;
    }
  }

  void goToNextLevel(bool value) {}

  void resetData() {
    // remove all basket
    for (var child in children) {
      remove(child);
    }

    // init
    init();
  }
}
