import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/screens/main_menu.dart';

late ScoreController scoreController;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  scoreController = ScoreController();
  await scoreController.start();
  Flame.device.fullScreen(); // run app in fullscreen
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GamePlay',
      ),
      home: MainMenu(
        scoreController: scoreController,
      ),
    );
  }
}
