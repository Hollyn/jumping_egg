import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/overlays/game_over_menu.dart';
import 'package:jumping_egg/overlays/pause_menu.dart';
import 'package:jumping_egg/overlays/sound_pause_buttons.dart';
import 'package:jumping_egg/overlays/sound_settings_menu.dart';

import '../controllers/server_client_controller.dart';
import '../models/multiplayer_game_data.dart';

// TODO: initialize the jumping egg game here
// JumpingEgg _game = JumpingEgg(scoreController: scoreController);

class GamePlay extends StatefulWidget {
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  final bool isMultiPlayer;
  const GamePlay({
    Key? key,
    required this.scoreController,
    required this.multiplayerGameData,
    required this.isMultiPlayer,
  }) : super(key: key);

  @override
  _GamePlayState createState() => _GamePlayState();
}

class _GamePlayState extends State<GamePlay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => false,
        child: GameWidget(
          game: JumpingEgg(
            scoreController: widget.scoreController,
            multiplayerGameData: widget.multiplayerGameData,
          ),
          initialActiveOverlays: [SoundPauseButtons.ID],
          overlayBuilderMap: {
            SoundPauseButtons.ID: (BuildContext context, JumpingEgg gameRef) =>
                SoundPauseButtons(
                  gameRef: gameRef,
                ),
            PauseMenu.ID: (BuildContext context, JumpingEgg gameRef) =>
                PauseMenu(
                  gameRef: gameRef,
                  scoreController: widget.scoreController,
                  multiplayerGameData: widget.multiplayerGameData,
                  isMultiplayer: widget.isMultiPlayer,
                ),
            GameOverMenu.ID: (BuildContext context, JumpingEgg gameRef) =>
                GameOverMenu(
                  gameRef: gameRef,
                  scoreController: widget.scoreController,
                  multiplayerGameData: widget.multiplayerGameData,
                ),
            SoundSettingsMenu.ID: (BuildContext context, JumpingEgg gameRef) =>
                SoundSettingsMenu(
                  gameRef: gameRef,
                  scoreController: widget.scoreController,
                ),
          },
        ),
      ),
    );
  }
}
