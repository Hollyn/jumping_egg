import 'package:flutter/material.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/overlays/pause_menu.dart';
import 'package:jumping_egg/overlays/sound_settings_menu.dart';

class SoundPauseButtons extends StatelessWidget {
  const SoundPauseButtons({Key? key, required this.gameRef}) : super(key: key);
  static const String ID = 'SoundPauseButtons';
  final JumpingEgg gameRef;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              gameRef.overlays.remove(SoundPauseButtons.ID);
              gameRef.overlays.add(PauseMenu.ID);
              gameRef.pauseEngine();
            },
            child: Image.asset('assets/images/buttons/pause_button.png'),
          ),
          // TextButton(
          //   onPressed: () {
          //     gameRef.overlays.remove(SoundPauseButtons.ID);
          //     gameRef.overlays.add(SoundSettingsMenu.ID);
          //     gameRef.pauseEngine();
          //   },
          //   child:
          //       Image.asset('assets/images/buttons/sound_options_button.png'),
          // ),
        ],
      ),
    );
  }
}
