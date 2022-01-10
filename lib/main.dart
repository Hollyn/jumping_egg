import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/game/game.dart';

JumpingEgg _game = JumpingEgg();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: _game);
  }
}
