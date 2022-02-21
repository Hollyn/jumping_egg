import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/overlays/pause_menu.dart';
import 'package:jumping_egg/overlays/sound_pause_buttons.dart';
import 'package:jumping_egg/overlays/sound_settings_menu.dart';

import '../overlays/game_over_menu.dart';

// TODO: initialize the jumping egg game here
// JumpingEgg _game = JumpingEgg(scoreController: scoreController);
class GamePlay extends StatelessWidget {
  final ScoreController scoreController;
  const GamePlay({Key? key, required this.scoreController}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: GameWidget(
          game: JumpingEgg(scoreController: scoreController),
          initialActiveOverlays: [SoundPauseButtons.ID],
          overlayBuilderMap: {
            SoundPauseButtons.ID: (BuildContext context, JumpingEgg gameRef) =>
                SoundPauseButtons(
                  gameRef: gameRef,
                ),
            PauseMenu.ID: (BuildContext context, JumpingEgg gameRef) =>
                PauseMenu(
                  gameRef: gameRef,
                  scoreController: scoreController,
                ),
            GameOverMenu.ID: (BuildContext context, JumpingEgg gameRef) =>
                GameOverMenu(
                  gameRef: gameRef,
                  scoreController: scoreController,
                ),
            SoundSettingsMenu.ID: (BuildContext context, JumpingEgg gameRef) =>
                SoundSettingsMenu(
                  gameRef: gameRef,
                  scoreController: scoreController,
                ),
          },
        ),
      ),
    );
  }
}
