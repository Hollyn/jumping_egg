import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/server_client_controller.dart';
import 'package:jumping_egg/main.dart';
import 'package:jumping_egg/screens/utils/guest_list_enum.dart';
import 'package:jumping_egg/screens/utils/playerEnum.dart';
import 'package:jumping_egg/screens/widgets/guest_widget.dart';
import 'package:jumping_egg/screens/widgets/host_widget.dart';

import '../models/multiplayer_game_data.dart';
import 'game_play.dart';

class MultiplayerPage extends StatefulWidget {
  final ServerClientController serverClientController;
  final MultiplayerGameData multiplayerGameData;
  const MultiplayerPage(
      {Key? key,
      required this.serverClientController,
      required this.multiplayerGameData})
      : super(key: key);

  @override
  _MultiplayerPageState createState() => _MultiplayerPageState();
}

bool isGuestConnected = false;
bool isGuestReceiveData = false;
String guestData = 'nothing yet';
bool isHostConnected = false;
bool isHostReceiveData = false;
String hostData = 'nothing yet';
GuestListEnum guestOption = GuestListEnum.searching;
List<String> guestList = [];
String guestName = '';
PlayerEnum playerEnum = PlayerEnum.nothing;
bool gameAlreadyStart = false;

class _MultiplayerPageState extends State<MultiplayerPage> {
  @override
  void initState() {
    super.initState();

    gameAlreadyStart = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              if (playerEnum == PlayerEnum.nothing ||
                  playerEnum == PlayerEnum.host)
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: (playerEnum == PlayerEnum.host)
                          ? null
                          : () {
                              setState(() {
                                playerEnum = PlayerEnum.host;
                                serverClientController.startServer(
                                  _onHostConnected,
                                  _onHostReceiveData,
                                );
                              });
                            },
                      child: Text('Host'),
                    ),
                  ),
                ),
              if (playerEnum == PlayerEnum.nothing ||
                  playerEnum == PlayerEnum.guest)
                Expanded(
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: (playerEnum == PlayerEnum.guest)
                          ? null
                          : () {
                              setState(() {
                                displayDialog(context);
                                playerEnum = PlayerEnum.guest;
                              });
                            },
                      child: Text('Guest'),
                    ),
                  ),
                ),
            ],
          ),
          if (playerEnum == PlayerEnum.host)
            HostWidget(
              serverClientController: serverClientController,
              scoreController: scoreController,
              isHostConnected: isHostConnected,
              isHostReceiveData: isHostReceiveData,
              hostData: hostData,
              guestOption: guestOption,
              guestList: guestList,
              onFindingGuest: _onFindingGuest,
              multiplayerGameData: multiplayerGameData,
            ),
          if (playerEnum == PlayerEnum.guest)
            GuestWidget(
              serverClientController: serverClientController,
              multiplayerGameData: multiplayerGameData,
              scoreController: scoreController,
              displayDialog: displayDialog,
              isGuestConnected: isGuestConnected,
              guestData: guestData,
              isGuestReceiveData: isGuestReceiveData,
            ),
        ],
      ),
    );
  }

  void displayDialog(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            elevation: 24,
            backgroundColor: Colors.white,
            // shape: CircleBorder(),
            title: Text('Enter your name'),
            content: TextField(
              controller: _textEditingController,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  widget.serverClientController.clientName =
                      _textEditingController.text;

                  serverClientController.startClient(
                    _onGuestConnected,
                    _onGuestReceiveData,
                  );
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    reset();
  }

  void reset() {
    isGuestConnected = false;
    isGuestReceiveData = false;
    guestData = 'nothing yet';
    isHostConnected = false;
    isHostReceiveData = false;
    hostData = 'nothing yet';
    guestOption = GuestListEnum.searching;
    guestList = [];
    guestName = '';
    playerEnum = PlayerEnum.nothing;
    // if (serverClientController.isServerRunning) {
    //   serverClientController.disposeServer();
    // }
    // if (serverClientController.isClientRunning) {
    //   serverClientController.disposeClient();
    // }
  }

  void _onGuestConnected(bool isConnected, String dataReceived) {
    if (!gameAlreadyStart) {
      setState(() {
        isGuestConnected = isConnected;
      });
    }
  }

  String prettyJson(dynamic json) {
    var spaces = ' ' * 4;
    var encoder = JsonEncoder.withIndent(spaces);
    return encoder.convert(json);
  }

  void _onGuestReceiveData(String data) {
    if (!gameAlreadyStart) {
      setState(() {
        isGuestReceiveData = true;
        guestData = data;
      });
    }
    try {
      final Map<String, dynamic> map =
          json.decode(data) as Map<String, dynamic>;
      widget.multiplayerGameData.fromJson(map);
      if (!gameAlreadyStart &&
          widget.multiplayerGameData.hostConnected == true &&
          widget.multiplayerGameData.guestConnected == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => GamePlay(
              scoreController: scoreController,
              serverClientController: serverClientController,
              multiplayerGameData: multiplayerGameData,
              isMultiPlayer: true,
            ),
          ),
        );
        gameAlreadyStart = true;
      }
    } catch (e) {
      print(e.toString());
    }
    ;
  }

  void _onHostConnected(bool isConnected, String dataReceived) {
    if (!gameAlreadyStart) {
      setState(() {
        isHostConnected = isConnected;
      });
      if (isConnected) {
        _onFindingGuest();
      }
    }
  }

  void _onFindingGuest() {
    if (!gameAlreadyStart) {
      setState(() {
        guestOption = GuestListEnum.searching;
      });
      serverClientController.findClients(_onListGuest);
    }
  }

  void _onHostReceiveData(String data) {
    print('game? $gameAlreadyStart');
    if (!gameAlreadyStart) {
      setState(() {
        isHostReceiveData = true;
        hostData = data;
      });
    }
    try {
      final Map<String, dynamic> map =
          json.decode(data) as Map<String, dynamic>;
      widget.multiplayerGameData.fromJson(map);
    } catch (e) {
      print(e.toString());
    }

    if (!gameAlreadyStart &&
        widget.multiplayerGameData.hostConnected == true &&
        widget.multiplayerGameData.guestConnected == true) {
      gameAlreadyStart = true;
    }
  }

  void _onListGuest(List<String> list) {
    if (!gameAlreadyStart) {
      setState(() {
        if (list.isNotEmpty) {
          guestOption = GuestListEnum.found;
        } else {
          guestOption = GuestListEnum.nothingFound;
        }
        guestList = list;
      });
    }
  }
}
