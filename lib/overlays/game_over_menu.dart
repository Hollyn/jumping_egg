import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/overlays/sound_pause_buttons.dart';
import 'package:jumping_egg/screens/main_menu.dart';

import '../controllers/server_client_controller.dart';
import '../models/multiplayer_game_data.dart';

class GameOverMenu extends StatelessWidget {
  final JumpingEgg gameRef;
  static const ID = 'GameOverMenu';
  final ScoreController scoreController;
  final ServerClientController serverClientController;
  final MultiplayerGameData multiplayerGameData;
  const GameOverMenu({
    Key? key,
    required this.gameRef,
    required this.scoreController,
    required this.serverClientController,
    required this.multiplayerGameData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Game over'),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              child: Text('Restart'),
              onPressed: () {
                gameRef.overlays.remove(GameOverMenu.ID);
                gameRef.overlays.add(SoundPauseButtons.ID);
                gameRef.resumeEngine();
                gameRef.resetGame();
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
                child: Text('Exit'),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainMenu(
                        scoreController: scoreController,
                        serverClientController: serverClientController,
                        multiplayerGameData: multiplayerGameData,
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
