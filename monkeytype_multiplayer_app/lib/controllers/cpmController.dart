import 'dart:math';

import 'package:get/get.dart';

class Cpmcontroller extends GetxController {
  RxDouble cpm = 0.0.obs;
  double maxcpm = 0, mincpm = 1e9;
  double maxwrongs = 0, minwrongs = 1e9;
  int wordsTypedRight = 0, wordsTypedWrong = 0;
  double acc = 0;

  List cpmReg =
      [
        [1, 400, 0],
        [2, 530, 2],
        [3, 340, 1],
        [4, 370, 0],
        [5, 500, 0],
        [6, 540, 2],
        [7, 570, 1],
        [7.83, 540, 0],
      ].obs;

  void clearController() {
    cpm.value = 0;
    cpmReg.clear();
    maxcpm = 0;
    mincpm = 1e9;
    maxwrongs = 0;
    minwrongs = 1e9;
  }

  void updateValues(
    double newcpm,
    double _timespan,
    int wrongsf,
    int wr,
    int ww,
  ) {
    cpm.value = newcpm;
    wordsTypedRight = wr;
    wordsTypedWrong = ww;
    acc = 100 * wr / (wr + ww);
    cpmReg.add([_timespan, newcpm, wrongsf]);
    maxcpm = max(maxcpm, newcpm);
    mincpm = min(mincpm, newcpm);
    maxwrongs = max(maxwrongs, wrongsf.toDouble());
    minwrongs = min(minwrongs, wrongsf.toDouble());
  }
}
