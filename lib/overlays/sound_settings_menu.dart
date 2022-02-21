import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/overlays/sound_pause_buttons.dart';

class SoundSettingsMenu extends StatefulWidget {
  final JumpingEgg gameRef;
  static const ID = 'SoundSettingsMenu';

  final ScoreController scoreController;
  const SoundSettingsMenu(
      {Key? key, required this.gameRef, required this.scoreController})
      : super(key: key);

  @override
  _SoundSettingsMenuState createState() => _SoundSettingsMenuState();
}

class _SoundSettingsMenuState extends State<SoundSettingsMenu> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Sound Setting'),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              child: Text('Resume'),
              onPressed: () {
                widget.gameRef.overlays.remove(SoundSettingsMenu.ID);
                widget.gameRef.overlays.add(SoundPauseButtons.ID);
                widget.gameRef.resumeEngine();
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              child: Text('Music'),
              onPressed: () {
                setState(() {
                  widget.scoreController.toggleMusic();
                  widget.gameRef.playBackgroundMusic();
                });
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
                child: Text('Sound Effect'),
                onPressed: () {
                  widget.scoreController.toggleSoundEffects();
                }),
          ),
        ],
      ),
    );
  }
}
