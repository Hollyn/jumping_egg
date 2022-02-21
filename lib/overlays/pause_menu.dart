import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/game/game.dart';
import 'package:jumping_egg/overlays/sound_pause_buttons.dart';
import 'package:jumping_egg/screens/main_menu.dart';

class PauseMenu extends StatelessWidget {
  final JumpingEgg gameRef;
  static const ID = 'PauseMenu';
  final ScoreController scoreController;
  const PauseMenu(
      {Key? key, required this.gameRef, required this.scoreController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Pause'),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              child: Text('Resume'),
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.ID);
                gameRef.overlays.add(SoundPauseButtons.ID);
                gameRef.resumeEngine();
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: ElevatedButton(
              child: Text('Restart'),
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.ID);
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
                      builder: (context) =>
                          MainMenu(scoreController: scoreController),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}