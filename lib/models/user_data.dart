import 'package:hive/hive.dart';
part 'user_data.g.dart';

@HiveType(typeId: 0)
class UserData extends HiveObject {
  @HiveField(0)
  late int highestScore;

  @HiveField(1)
  late int coin;

  @HiveField(2)
  late bool soundEffect;

  @HiveField(3)
  late bool music;

  void setHighestScore(int score) {
    highestScore = score;
    save();
  }

  void addCoin() {
    coin++;
    save();
  }
}
