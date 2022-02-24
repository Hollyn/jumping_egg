import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/controllers/server_client_controller.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/models/multiplayer_game_data.dart';
import 'package:jumping_egg/screens/game_play.dart';
import 'package:jumping_egg/screens/main_menu.dart';
import 'package:jumping_egg/screens/multiplayer.dart';

class GameOverMultiPlayer extends StatelessWidget {
  final ScoreController scoreController;
  final ServerClientController serverClientController;
  final MultiplayerGameData multiplayerGameData;
  final JumpingEgg gameRef;
  static String ID = 'GameOverMultiPlayer';

  const GameOverMultiPlayer({
    Key? key,
    required this.gameRef,
    required this.scoreController,
    required this.serverClientController,
    required this.multiplayerGameData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'You are dead',
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score : ',
            ),
            Text(
              serverClientController.isClientRunning
                  ? multiplayerGameData.guestScore.toString()
                  : multiplayerGameData.hostScore.toString(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              serverClientController.isServerRunning
                  ? "Guest's Score : "
                  : "Host's Score : ",
            ),
            Text(
              serverClientController.isClientRunning
                  ? multiplayerGameData.hostScore.toString()
                  : multiplayerGameData.guestScore.toString(),
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: ElevatedButton(
            onPressed: () {
              if (serverClientController.isServerRunning) {
                multiplayerGameData.hostConnected = false;
                serverClientController.serverToClient(
                  serverClientController.clientName,
                  multiplayerGameData.toJson().toString(),
                );
                serverClientController.disposeServer();
              } else {
                multiplayerGameData.guestConnected = false;
                serverClientController.clientToServer(
                  multiplayerGameData.toJson().toString(),
                );
                serverClientController.disposeClient();
              }
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => MainMenu(
                    scoreController: scoreController,
                    serverClientController: serverClientController,
                    multiplayerGameData: multiplayerGameData,
                  ),
                ),
              );
            },
            child: const Text('Go to main menu'),
          ),
        ),
      ],
    );
  }
}
