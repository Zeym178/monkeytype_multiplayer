import 'package:get/get.dart';

class Cpmcontroller extends GetxController {
  RxDouble cpm = 0.0.obs;
  List cpmReg =
      [
        [1, 400],
        [2, 530],
        [3, 340],
        [4, 370],
        [5, 500],
        [6, 540],
        [7, 570],
        [7.83, 540],
      ].obs;

  void clearController() {
    cpm.value = 0;
    cpmReg.clear();
  }
}
