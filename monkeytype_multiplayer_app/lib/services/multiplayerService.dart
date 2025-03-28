import 'package:monkeytype_multiplayer_app/controllers/multiplayerController.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Multiplayerservice {
  late IO.Socket socket;
  late Multiplayercontroller multiplayercontroller;
  String BASE_URL = "http://localhost:5000";

  Multiplayerservice(Multiplayercontroller mc) {
    multiplayercontroller = mc;
  }

  void startConnection() {
    socket = IO.io(
      BASE_URL,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket.connect();
    onMessageReceived();
  }

  void sendCpm(double cpm) {
    socket.emit("cpm", cpm);
  }

  void onMessageReceived() {
    socket.on("connected-users", (data) {
      print(data);
      multiplayercontroller.usersConnected.value = data;
    });

    socket.on("cpm-received", (data) {
      double value = data['cpm'];
      multiplayercontroller.otherCpm.value = value;
    });
  }

  void disconnect() {
    socket.disconnect();
  }
}
