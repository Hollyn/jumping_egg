import 'package:flame_audio/flame_audio.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:flame/components.dart';

class SoundPlayerComponent extends Component {
  final JumpingEgg gameRef;
  SoundPlayerComponent({required this.gameRef});

  @override
  Future<void>? onLoad() {
    FlameAudio.audioCache.loadAll([
      'background_music.mp3',
      'collect_coin.wav',
      'fall.wav',
      'jump.mp3',
      'landing.mp3',
      'collect_coin.mp3',
    ]);
    return super.onLoad();
  }

  void playBGM() {
    if (gameRef.buildContext != null) {
      FlameAudio.bgm.play('background_music.mp3');
    }
  }

  void playSound(String filename) {
    if (gameRef.buildContext != null) {
      FlameAudio.play(filename);
    }
  }

  void stopBGM() {
    FlameAudio.bgm.stop();
  }
}
