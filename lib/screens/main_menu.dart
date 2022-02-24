import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/controllers/server_client_controller.dart';
import 'package:jumping_egg/models/multiplayer_game_data.dart';
import 'package:jumping_egg/screens/game_play.dart';
import 'package:jumping_egg/screens/multiplayer.dart';

class MainMenu extends StatelessWidget {
  final ScoreController scoreController;
  final ServerClientController serverClientController;
  final MultiplayerGameData multiplayerGameData;
  const MainMenu({
    Key? key,
    required this.scoreController,
    required this.serverClientController,
    required this.multiplayerGameData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Jumping Egg',
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Highest Score : ',
              ),
              Text(scoreController.getHighestScore().toString()),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => GamePlay(
                      scoreController: scoreController,
                      serverClientController: serverClientController,
                      multiplayerGameData: multiplayerGameData,
                      isMultiPlayer: false,
                    ),
                  ),
                );
              },
              child: const Text('PLAY'),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MultiplayerPage(
                      serverClientController: serverClientController,
                      multiplayerGameData: multiplayerGameData,
                    ),
                  ),
                );
              },
              child: Text('MULTIPLAYER'),
            ),
          ),
        ],
      ),
    );
  }
}
