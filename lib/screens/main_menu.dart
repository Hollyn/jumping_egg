import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/screens/game_play.dart';

class MainMenu extends StatelessWidget {
  final ScoreController scoreController;
  const MainMenu({Key? key, required this.scoreController}) : super(key: key);

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
                          )),
                );
              },
              child: const Text('PLAY'),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('MULTIPLAYER'),
            ),
          ),
        ],
      ),
    );
  }
}
