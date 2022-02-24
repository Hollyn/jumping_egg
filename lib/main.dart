import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/controllers/server_client_controller.dart';
import 'package:jumping_egg/models/multiplayer_game_data.dart';
import 'package:jumping_egg/screens/main_menu.dart';

late ScoreController scoreController;
late ServerClientController serverClientController;
late MultiplayerGameData multiplayerGameData;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  scoreController = ScoreController();
  await scoreController.start();
  Flame.device.fullScreen(); // run app in fullscreen
  // initialize server-client class
  serverClientController = ServerClientController();
  multiplayerGameData = MultiplayerGameData();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'GamePlay',
      ),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MainMenu(
      scoreController: scoreController,
      serverClientController: serverClientController,
      multiplayerGameData: multiplayerGameData,
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'GamePlay',
//       ),
//       home: MainMenu(
//           scoreController: scoreController,
//           serverClientController: serverClientController),
//     );
//   }
// }
