import 'package:flame/components.dart';
import 'package:jumping_egg/game/basket.dart';
import 'package:jumping_egg/game/basket_data_manager.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/helpers/constant.dart';

class BasketManager extends Component with HasGameRef<JumpingEgg> {
  final Sprite sprite;
  late List<Basket> basketList = [];
  int _numberOfBasketDisposed = 0;
  BasketDataManager basketDataManager = BasketDataManager();

  BasketManager({required this.sprite}) : super();

  @override
  Future<void> onLoad() async {
    // Only runs once, when the component is loaded.
    init();
  }

  void init() {
    for (var i = 0; i < 3; i++) {
      addBasket(
        position: Vector2(gameRef.size.x / 2, (3 - i) * gameRef.size.y / 4),
        falling: false,
      );
    }
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

    basketList.add(basket);
    add(basket);
  }

  Basket getBasketAt(int position) {
    return basketList[position];
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (children.isNotEmpty && basketList[0].position.y > gameRef.size.y) {
      remove(basketList[0]);
      basketList.removeAt(0);
      _numberOfBasketDisposed++; // update number of basket disposed

      addBasket(position: Vector2(gameRef.size.x / 2, 0), falling: true);
    }
  }

  void goToNextLevel(bool value) {
    for (var i = 0; i < basketList.length; i++) {
      basketList[i].isFalling = value;
    }
    if (value) {
      if (basketList.length < 4) {
        addBasket(position: Vector2(gameRef.size.x / 2, 0), falling: true);
      }
    } else {
      _numberOfBasketDisposed = 0;
    }
  }

  int getNumberOfBasketDisposed() {
    return _numberOfBasketDisposed;
  }

  void resetData() {
    // empty basket list
    basketList = [];

    // remove all basket
    for (var child in children) {
      remove(child);
    }

    // init
    init();
  }
}
