import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jumping_egg/controllers/score_controller.dart';
import 'package:jumping_egg/controllers/server_client_controller.dart';
import 'package:jumping_egg/helpers/constant.dart';
import 'package:jumping_egg/main.dart';
import 'package:jumping_egg/screens/main_menu.dart';
import 'package:jumping_egg/screens/utils/guest_list_enum.dart';
import 'package:jumping_egg/screens/widgets/guest_list_item_widget.dart';

import '../../models/multiplayer_game_data.dart';
import '../game_play.dart';

// HostWidget
late String clientName;

class HostWidget extends StatefulWidget {
  final ServerClientController serverClientController;
  final ScoreController scoreController;
  final MultiplayerGameData multiplayerGameData;
  final bool isHostConnected;
  final bool isHostReceiveData;
  final String hostData;
  final GuestListEnum guestOption;
  final List<String> guestList;
  final Function onFindingGuest;

  const HostWidget({
    Key? key,
    required this.serverClientController,
    required this.isHostConnected,
    required this.isHostReceiveData,
    required this.hostData,
    required this.guestOption,
    required this.guestList,
    required this.onFindingGuest,
    required this.scoreController,
    required this.multiplayerGameData,
  }) : super(key: key);

  @override
  _HostWidgetState createState() => _HostWidgetState();
}

class _HostWidgetState extends State<HostWidget> {
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
                      scoreController: scoreController,
                      serverClientController: widget.serverClientController,
                      multiplayerGameData: widget.multiplayerGameData,
                    ),
                  ),
                );
              },
              child: Text('back')),
          Text('Connecting ...'),
          if (widget.guestOption == GuestListEnum.searching)
            Text('Looking for guests ...')
          else if (widget.guestOption == GuestListEnum.found)
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.guestList.length,
              itemBuilder: (context, index) {
                return GuestListItemWidget(
                  colour: Color(0Xffffffff),
                  onPress: () {
                    clientName = widget.guestList[index];
                    widget.serverClientController.clientName = clientName;
                    widget.multiplayerGameData.hostConnected = true;
                    print(json.encode(widget.multiplayerGameData.toJson()));
                    widget.serverClientController.serverToClient(
                      clientName,
                      json.encode(widget.multiplayerGameData.toJson()),
                    );
                  },
                  cardChild: Text(
                    widget.guestList[index],
                    style: TextStyle(color: kCharacterColor),
                  ),
                );
              },
            ),
          // else if (widget.guestOption == GuestListEnum.nothingFound)
          Container(
            child: Column(
              children: [
                Text('Nothing found'),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onFindingGuest();
                    },
                    child: Text('Retry'),
                  ),
                )
              ],
            ),
          ),
          if (widget.isHostReceiveData && widget.hostData.isNotEmpty)
            ElevatedButton(
              onPressed: () {
                widget.multiplayerGameData.gameStart = true;
                widget.serverClientController.serverToClient(
                  clientName,
                  jsonEncode(widget.multiplayerGameData.toJson()),
                );

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
              },
              child: Text('Play'),
            ),
          // else
          //   Container(
          //     child: Column(
          //       children: [
          //         Text('Cannot connect to client'),
          //         SizedBox(
          //           child: ElevatedButton(
          //             onPressed: () {
          //               widget.onFindingGuest();
          //             },
          //             child: Text('Retry'),
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
        ],
      ),
    );
  }
}
