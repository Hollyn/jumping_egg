import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

double speedY = 0.0;

class Nest extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {
  Nest({Sprite? sprite, Vector2? size, Vector2? position, Anchor? anchor})
      : super(position: position, size: size, sprite: sprite, anchor: anchor);

  @override
  void onMount() {
    super.onMount();

    final shape = HitboxPolygon([
      Vector2(1, 0),
      Vector2(-1, 0),
    ]);
    addHitbox(shape);
  }
}
