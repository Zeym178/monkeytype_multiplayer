import 'package:monkeytype_multiplayer_app/controllers/multiplayerController.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Multiplayerservice {
  late IO.Socket socket;
  late Multiplayercontroller multiplayercontroller;
  String BASE_URL = "http://localhost:5000";
  String roomName = "";

  Multiplayerservice(Multiplayercontroller mc) {
    multiplayercontroller = mc;
  }

  void startConnection(String localRoomName) {
    roomName = localRoomName;
    socket = IO.io(
      BASE_URL,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();
    socket.emit("join-socket", roomName);
    onMessageReceived();
  }

  void sendCpm(double cpm, double percentange) {
    socket.emit("cpm", {
      "roomName": roomName,
      "cpm": cpm,
      "percentage": percentange,
    });
    multiplayercontroller.yourPercentage.value = percentange;
  }

  void onMessageReceived() {
    socket.on("connected-users", (data) {
      print(data);
      // multiplayercontroller.usersConnected.value = data;
      var auxmap = <String, dynamic>{};
      var auxOri = multiplayercontroller.othersInfo;
      for (var i = 0; i < data.length; i++) {
        if (auxOri.containsKey(data[i])) {
          auxmap[data[i]] = auxOri[data[i]];
        } else {
          auxmap[data[i]] = {"cpm": 0.0, "percentage": 0.0};
        }
      }
      multiplayercontroller.othersInfo.value = auxmap;
      multiplayercontroller.usersList.value = data;
      multiplayercontroller.usersConnected.value = data.length;
    });

    socket.on("cpm-received", (data) {
      String otherId = data['sentBy'];
      // print(data['data']);
      multiplayercontroller.othersInfo[otherId] = data['data'];
      print("nose");
      print(multiplayercontroller.othersInfo[otherId]);
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
