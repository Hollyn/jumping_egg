import 'package:flame/components.dart';
import 'package:flame/geometry.dart';

import 'nest.dart';

const GRAVITY = 400.0;
const BOOST = -300.0;
double speedY = 0.0;
class Player extends SpriteComponent with HasGameRef, HasHitboxes, Collidable {

  Player(sprite, width, height, position, anchor) {
    this.sprite = sprite;
    this.width = width;
    this.height = height;
    this.position = position;
    this.anchor = anchor;
  }

  jump(){
    speedY = (speedY + BOOST).clamp(BOOST, speedY);
  }

  @override
  void update(double dt) {
    super.update(dt);

    y += speedY * dt - GRAVITY * ((dt * dt) / 2);
    speedY += GRAVITY * dt;

    if (y > gameRef.size.y){
      reset();
    }
  }

  reset() {
    speedY = 0.0;
    position = gameRef.size/2;
  }



  @override
  void onMount() {
    super.onMount();

    final shape = HitboxCircle();
    addHitbox(shape);

  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Nest){
      speedY = 0.0;
    }
  }
}
