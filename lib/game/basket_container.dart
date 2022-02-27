import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flame/palette.dart';
import 'package:jumping_egg/game/basket.dart';
import 'package:jumping_egg/game/basket_data_manager.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/helpers/constant.dart';

late HitboxShape shape;

class BasketContainer extends PositionComponent
    with HasGameRef<JumpingEgg>, HasHitboxes, Collidable {
  final Sprite sprite;
  BasketDataManager basketDataManager = BasketDataManager();

  BasketContainer({
    required this.sprite,
    Vector2? position,
    Vector2? size,
    Vector2? scale,
    double? angle,
    Anchor? anchor,
    int? priority,
  }) : super(
          position: position,
          size: size,
          scale: scale,
          angle: angle,
          anchor: anchor,
          priority: priority,
        ) {
    shape = HitboxRectangle();
    addHitbox(shape);
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

  final Paint hitboxPaint = BasicPalette.red.paint()
    ..style = PaintingStyle.stroke;
  final Paint dotPaint = BasicPalette.red.paint()..style = PaintingStyle.stroke;

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    shape.render(canvas, hitboxPaint);
  }

  void init() {
    addBasket(
      position: position,
      falling: false,
    );
  }

  void addBasket({required Vector2 position, required bool falling}) {
    final Basket basket = Basket(
      sprite: sprite,
      size: Vector2(kSpriteSize, kSpriteSize),
      position: position,
      priority: 1,
      isFalling: falling,
      direction: basketDataManager.getRandomBasketData().getDirection(),
    );

    add(basket);
  }

  @override
  void update(double dt) {
    super.update(dt);
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
