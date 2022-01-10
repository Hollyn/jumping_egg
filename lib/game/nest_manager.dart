import 'package:flame/components.dart';
import 'package:jumping_egg/game/nest.dart';
import 'package:jumping_egg/game/nest_data_manager.dart';

class NestManger extends SpriteComponent with HasGameRef {
  late final double _nestLowerPosition;
  final NestDataManager _nestDataManager = NestDataManager();
  int _nestNumber = 0;
  List<Nest> nests = [];
  bool _goingToNextLevel = false;

  NestManger({required Sprite sprite}) : super(sprite: sprite) {
    _nestLowerPosition = (gameRef.size.y / 4) * 3;
  }

  void addNestsInTheGame(int numberOfNest) {
    bool init = false;
    if (nests.isEmpty) {
      init = true;
    }
    for (var i = numberOfNest - 1; i >= 0; i--) {
      final randomNestData = _nestDataManager.getRandomNestData();
      final Nest nest = Nest(
        sprite: sprite!,
        size: Vector2(width, height),
        position: init
            ? Vector2(gameRef.size.x / 2, (gameRef.size.y / 4) * (i + 1))
            : Vector2(gameRef.size.x / 2, (gameRef.size.y / 4) * (i - 1)),
        direction: randomNestData.getDirection(),
        speed: randomNestData.getSpeed(),
      );
      nests.add(nest);
      add(nest);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (_nestNumber == 2) {
      // add nests
      addNestsInTheGame(2);
      moveAllNestsDown(value: true);
    }

    // going to the next level
    if (goingToNextLevel) {
      if (topNest.initPosition.y >= _nestLowerPosition) {
        moveAllNestsDown(value: false);
        _nestNumber = 0;
      }
    }
  }

  void moveAllNestsDown({required bool value}) {
    _goingToNextLevel = value;
    for (var i = 0; i < nests.length; i++) {
      nests[i].goDown(value: value);
    }

    if (!value) {
      // remove the 2 first nests and add 2 nests at the tail

      final Nest nest = nests[2];

      remove(nests[0]);
      remove(nests[1]);
      nests.removeAt(0);
      nests.removeAt(1);

      nests[0] = nest;
    }
  }

  Nest get currentNest => nests[_nestNumber];
  Nest get nextNest => nests[_nestNumber + 1];
  Nest get topNest => nests[2];
  bool get goingToNextLevel => _goingToNextLevel;

  void updateNestNumber() {
    _nestNumber++;
  }
}
