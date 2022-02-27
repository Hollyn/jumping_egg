import 'dart:math';

import 'package:flame/components.dart';
import 'package:jumping_egg/game/coin.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/helpers/constant.dart';

class CoinManager extends Component {
  late Random random;
  final JumpingEgg gameRef;
  final Sprite sprite;
  late Coin coin;
  late Timer timer;

  late List<Coin> coinList;
  CoinManager({required this.sprite, required this.gameRef}) {
    random = Random();
    timer = Timer(60, onTick: _spawnCoin, repeat: true);
  }

  void _spawnCoin() {
    int playerScore = gameRef.player.getCurrentScore() as int;
    coinList = gameRef.children.whereType<Coin>().toList();
    if (playerScore > 0 && (coinList.isEmpty)) {
      addCoin(random.nextInt(2) + 1);
    }
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    timer.update(dt);
  }

  void addCoin(int position) {
    final Vector2 coinPosition =
        gameRef.basketManager.getBasketContainerAt(position).position.clone();
    coin = Coin(
      sprite: sprite,
      size: Vector2(kCoinSize, kCoinSize),
      position: coinPosition,
    );
    gameRef.add(coin);
  }

  @override
  void onRemove() {
    super.onRemove();
    timer.stop();
  }
}
