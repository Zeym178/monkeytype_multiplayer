import 'package:get/get.dart';

class Multiplayercontroller extends GetxController {
  var yourPercentage = 0.0.obs;

  var usersConnected = 0.obs;

  var usersList = [].obs;

  // these are gonna be lists in the future
  var othersInfo = <String, dynamic>{}.obs;
}
