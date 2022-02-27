import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/controllers/server_client_controller.dart';
import 'package:jumping_egg/helpers/constant.dart';
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
      backgroundColor: Color(0xdefee3bc),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Jumping Egg',
            style: kGameTitleStyle,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Highest Score : ',
                style: kGameSubTitleStyle,
              ),
              Text(
                scoreController.getHighestScore().toString(),
                style: kGameSubTitleStyle,
              ),
            ],
          ),
          SizedBox(
            height: 50.0,
          ),
          SizedBox(
            width: 150,
            child: TextButton(
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
              child: Image.asset('assets/images/buttons/play_button.png'),
            ),
          ),
          SizedBox(
            width: 100,
            child: TextButton(
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
              child:
                  Image.asset('assets/images/buttons/multiPlayer_button.png'),
            ),
          ),
        ],
      ),
    );
  }
}
