// import 'dart:async';
// import 'dart:convert';
// import 'package:client_server_lan/client_server_lan.dart';
//
// class ServerClientController {
//   bool isServerLoading = false;
//   bool isClientLoading = false;
//   String serverDataReceived = '';
//   String clientDataReceived = '';
//   bool isClientRunning = false;
//   String serverStatus = '';
//   String clientStatus = '';
//   String serverName = 'jumping_egg_server';
//   String clientName = 'jumping_egg_client';
//   bool isServerRunning = false;
//
//   // Server
//   late ServerNode server;
//   List<ConnectedClientNode> connectedClientNodes = [];
//
//   // Client
//   late ClientNode client;
//
//   Future<void> startServer(
//       Function onServerConnected, Function onServerReceiveData) async {
//     var name = 'Server';
//     name = serverName;
//     isServerLoading = true;
//     server = ServerNode(
//       name: name,
//       verbose: true,
//       onDispose: onDisposeServer,
//       clientDispose: clientDispose,
//       onError: onError,
//     );
//
//     await server.init();
//     await server.onReady;
//
//     serverStatus =
//         'Server ready on ${server.host}:${server.port} (${server.name})';
//     isServerRunning = true;
//     isServerLoading = false;
//     onServerConnected(isServerRunning, serverStatus);
//
//     server.dataResponse.listen((DataPacket data) {
//       // setState(() {
//       serverDataReceived = json.encode(data.payload);
//
//       if (data.name == clientName) {
//         onServerReceiveData(serverDataReceived);
//       }
//       // });
//     });
//   }
//
//   void disposeServer() {
//     // setState(() {
//     print('serverDisposed');
//     isServerLoading = true;
//     // });
//     server.dispose();
//   }
//
//   void onDisposeServer() {
//     // setState(() {
//     isServerRunning = false;
//     serverStatus = 'Server is not running';
//     isServerLoading = false;
//     connectedClientNodes = [];
//     // });
//   }
//
//   Future<void> clientDispose(ConnectedClientNode c) async {
//     // setState(() {
//     connectedClientNodes = [];
//     // });
//     for (final s in server.clientsConnected) {
//       // setState(() {
//       connectedClientNodes.add(s);
//       // });
//     }
//   }
//
//   Future<void> findClients(Function onListClient) async {
//     await server.discoverNodes();
//     await Future<Object>.delayed(const Duration(seconds: 2));
//     // setState(() {
//     connectedClientNodes = [];
//     // });
//     List<String> clientNames = [];
//     for (final s in server.clientsConnected) {
//       // setState(() {
//       connectedClientNodes.add(s);
//       clientNames.add(s.name);
//       // });
//     }
//     onListClient(clientNames);
//   }
//
//   Future<void> serverToClient(String clientName, String message) async {
//     final client = server.clientUri(clientName);
//     await server.sendData(message, 'userInfo', client);
//   }
//
//   // Client
//   Future<void> startClient(
//       Function onClientConnected, Function onClientReceiveData) async {
//     var name = 'Client';
//     // var deviceInfo = await DeviceInfoPlugin().androidInfo;
//     name = clientName;
//     // setState(() {
//     isClientLoading = true;
//     client = ClientNode(
//       name: name,
//       verbose: true,
//       onDispose: onDisposeClient,
//       onServerAlreadyExist: onServerAlreadyExist,
//       onError: onError,
//     );
//     // });
//
//     await client.init();
//     await client.onReady;
//
//     // setState(() {
//     clientStatus =
//         'Client ready on ${client.host}:${client.port} (${client.name})';
//     isClientRunning = true;
//     isClientLoading = false;
//
//     onClientConnected(isClientRunning, clientStatus);
//     // });
//
//     client.dataResponse.listen((DataPacket data) {
//       // setState(() {
//       clientDataReceived = jsonEncode(data.payload);
//       onClientReceiveData(clientDataReceived);
//       // });
//     });
//   }
//
//   void disposeClient() {
//     print('client Disposed');
//     client.dispose();
//   }
//
//   void onDisposeClient() {
//     // setState(() {
//     isClientRunning = false;
//     clientStatus = 'Client is not running';
//     isClientLoading = false;
//     // });
//   }
//
//   void handShake() {}
//
//   Future<void> onServerAlreadyExist(DataPacket dataPacket) async {
//     print('Server already exist on ${dataPacket.host} (${dataPacket.name})');
//   }
//
//   Future<void> checkServerExistance() async {
//     await client.discoverServerNode();
//   }
//
//   void clientToServer(dynamic message) async {
//     await client.sendData(message, 'userInfo');
//   }
//
//   Future<void> onError(String error) async {
//     print(error);
//   }
// }
