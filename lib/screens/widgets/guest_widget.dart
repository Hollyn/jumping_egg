import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/server_client_controller.dart';

import '../../controllers/score_controller.dart';
import '../../models/multiplayer_game_data.dart';
import '../main_menu.dart';

// GUEST
class GuestWidget extends StatefulWidget {
  final ServerClientController serverClientController;
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  final Function displayDialog;

  final bool isGuestConnected;
  final bool isGuestReceiveData;
  final String guestData;

  const GuestWidget({
    Key? key,
    required this.serverClientController,
    required this.scoreController,
    required this.multiplayerGameData,
    required this.displayDialog,
    required this.isGuestConnected,
    required this.isGuestReceiveData,
    required this.guestData,
  }) : super(key: key);

  @override
  _GuestWidgetState createState() => _GuestWidgetState();
}

class _GuestWidgetState extends State<GuestWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => MainMenu(
                      scoreController: widget.scoreController,
                      serverClientController: widget.serverClientController,
                      multiplayerGameData: widget.multiplayerGameData,
                    ),
                  ),
                );
              },
              child: Text('back')),
          Text('Looking for a host'),
          ElevatedButton(
            onPressed: () {
              widget.displayDialog(context);
            },
            child: Text('retry'),
          ),
          if (widget.isGuestConnected) Text('Waiting for host'),
          if (widget.isGuestReceiveData && widget.guestData.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                widget.multiplayerGameData.guestConnected = true;
                widget.serverClientController.clientToServer(
                  jsonEncode(widget.multiplayerGameData.toJson()),
                );
              },
              child: Text('ok'),
            ),
          Text(widget.guestData),
        ],
      ),
    );
  }
}
