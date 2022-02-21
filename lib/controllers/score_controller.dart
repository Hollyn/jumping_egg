import 'package:hive_flutter/adapters.dart';
import 'package:jumping_egg/helpers/constant.dart';
import 'package:jumping_egg/models/user_data.dart';

class ScoreController {
  late Box _box;

  Future<void> start() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserDataAdapter());
    _box = await Hive.openBox(kBoxScoreName);
    if (_box.get(kBoxScoreName) == null) {
      initBox();
    }
  }

  void initBox() {
    _box.put(
      kBoxScoreName,
      UserData()
        ..highestScore = 0
        ..coin = 0
        ..soundEffect = true
        ..music = true,
    );
  }

  int getHighestScore() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    return userData.highestScore;
  }

  void setHighestScore(int newHighestScore) {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    final int currentHighestScore = userData.highestScore;

    if (newHighestScore > currentHighestScore) {
      userData.highestScore = newHighestScore;
      userData.save();
    }
  }

  void addCoin() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    userData.coin = userData.coin + 1;
    userData.save();
  }

  int getCoin() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    return userData.coin;
  }

  UserData getPlayerData() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    return userData;
  }

  void toggleMusic() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    userData.music = !userData.music;
    userData.save();
  }

  void toggleSoundEffects() {
    final UserData userData = _box.get(kBoxScoreName) as UserData;
    userData.soundEffect = !userData.soundEffect;
    userData.save();
  }
}
