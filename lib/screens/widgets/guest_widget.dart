import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/server_client_controller.dart';
import 'package:jumping_egg/helpers/constant.dart';
import 'package:jumping_egg/screens/multiplayer.dart';
import 'package:jumping_egg/screens/utils/guest_choose_name.dart';
import 'package:jumping_egg/screens/widgets/button_text_with_background.dart';

import '../../controllers/score_controller.dart';
import '../../models/multiplayer_game_data.dart';
import '../main_menu.dart';

// GUEST
late bool okAlreadyPressed;

class GuestWidget extends StatefulWidget {
  final ServerClientController serverClientController;
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  final Function displayDialog;
  final bool isGuestChoseName;

  final bool isGuestConnected;
  final bool isGuestReceiveData;
  final String guestData;
  final GuestChooseName guestChooseName;

  const GuestWidget({
    Key? key,
    required this.serverClientController,
    required this.scoreController,
    required this.multiplayerGameData,
    required this.displayDialog,
    required this.isGuestConnected,
    required this.isGuestReceiveData,
    required this.guestData,
    required this.isGuestChoseName,
    required this.guestChooseName,
  }) : super(key: key);

  @override
  _GuestWidgetState createState() => _GuestWidgetState();
}

class _GuestWidgetState extends State<GuestWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    okAlreadyPressed = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          if (guestChooseName == GuestChooseName.cancel)
            ButtonTextWithBackground(
              onPressed: () {
                widget.displayDialog(context);
              },
              title: 'retry',
            ),
          SizedBox(
            height: 24,
          ),
          if (widget.isGuestConnected && widget.guestData.isEmpty)
            Text(
              'Waiting for host ...',
              style: kDialogSubTitleStyle,
            ),
          if (widget.isGuestReceiveData && widget.guestData.isNotEmpty)
            Column(
              children: [
                Text(
                  "Let's play",
                  style: kDialogSubTitleStyle,
                ),
                SizedBox(
                  height: 18,
                ),
                ButtonTextWithBackground(
                  onPressed: (okAlreadyPressed)
                      ? () {}
                      : () {
                          widget.multiplayerGameData.guestConnected = true;
                          widget.serverClientController.clientToServer(
                            jsonEncode(widget.multiplayerGameData.toJson()),
                          );
                        },
                  title: 'OK',
                ),
              ],
            ),
        ],
      ),
    );
  }
}
