import 'dart:async';
import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monkeytype_multiplayer_app/pages/results_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();

  final String TypeText =
      "hola como estamos el dia de hoy mis compadres y comadres, como les va el dia de hoy, no me la counter strike";
  late String userText;
  int originalIndex = 0, userIndex = 0;
  late int originalSize;
  List<Map> _text = [];
  List<List> _words = [];
  List wordsIni = [];
  bool isRight = true;
  int wrongsf = 0;
  int wordsIniIndex = 0;
  int wordsTypedRight = 0;

  double cpmsf = 0;
  double cpm = 0;

  int isTyping = -1;

  Timer? _timer;
  Stopwatch _stopwatch = Stopwatch();
  double _timespan = 0.0;

  void startTimer() {
    _stopwatch.reset();
    _stopwatch.start();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _timespan = _stopwatch.elapsedMilliseconds.toDouble();
        cpm = wordsTypedRight * 60 / (_timespan / 1000);
      });
    });
  }

  void stopTimer() {
    _stopwatch.stop();
    _timer?.cancel();
    _timer = null;
  }

  void finishTest() {
    _timespan = _stopwatch.elapsedMilliseconds.toDouble();
    stopTimer();
    // cpm =  wordsTypedRight * 60 / (_timespan / 1000)
    print("words typed right: " + wordsTypedRight.toString());
    cpm = wordsTypedRight * 60 / (_timespan / 1000);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ResultsPage(cpm: cpm)),
    );
  }

  void getListValues() {
    setState(() {
      int auxcount = 0;
      _words.clear();
      for (int i = 0; i < _text.length; i++) {
        _text[i]['index'] = i;
        if (_text[i]['char'] == " ") {
          _words.add(_text.sublist(auxcount, i + 1));
          auxcount = i + 1;
        }
      }
      _words.add(_text.sublist(auxcount, _text.length));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    originalSize = TypeText.length;
    userText = TypeText;
    int auxcount = 0;
    wordsIni.add(0);
    for (int i = 0; i < TypeText.length; i++) {
      _text.add({"char": TypeText[i], "color": 0, "index": i});
      if (TypeText[i] == " ") {
        _words.add(_text.sublist(auxcount, i + 1));
        auxcount = i + 1;
        wordsIni.add(i + 1);
      }
    }
    _words.add(_text.sublist(auxcount, TypeText.length));

    // for (int i = 0; i < _words.length; i++) {
    //   print(_words[i]);
    // }

    super.initState();
  }

  void compare(String key) {
    // at the beggining of everything I guess lol
    if (isTyping == -1) {
      startTimer();
    }

    // the rest of the time
    if (isTyping != 0) {
      setState(() {
        isTyping = 1;
        if (originalIndex >= TypeText.length - 1) {
          isTyping = 0;
        }
        if (wrongsf == 0) {
          isRight = true;
          wrongsf = 0;
        }
        if (!isRight && key == ' ' && _text[userIndex]['char'] != ' ') {
          wrongsf = 0;
          isRight = true;
          wordsIniIndex++;
          int newindex = wordsIni[wordsIniIndex] - originalIndex;
          originalIndex = wordsIni[wordsIniIndex];
          userIndex += newindex;
          return;
        }
        if (isRight && key == ' ' && _text[userIndex]['char'] == ' ') {
          wordsIniIndex++;
        } else if (isRight && key == ' ') {
          return;
        }
        if (key == 'Backspace') {
          if (wrongsf > 0) {
            _text = _text.sublist(0, userIndex - 1) + _text.sublist(userIndex);
            getListValues();
            userIndex--;
            wrongsf--;
          }
          return;
        }
        if (key != TypeText[originalIndex] || !isRight) {
          _text =
              _text.sublist(0, userIndex) +
              [
                {'char': key, 'color': -1},
              ] +
              _text.sublist(userIndex);
          getListValues();
          userIndex++;
          wrongsf++;
          isRight = false;
          return;
        }
        wordsTypedRight++;
        _text[userIndex]['color'] = 1;
        getListValues();
        userIndex++;
        originalIndex++;
      });

      // user's has finished mman
      print(TypeText);
      if (isTyping == 0) {
        finishTest();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 200),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // right stuff
                      Row(
                        children: [
                          // logo
                          Center(
                            child: SvgPicture.asset(
                              'assets/images/app_logo.svg',
                              height: 50,
                              width: 50,
                              color: mytheme.secondary,
                            ),
                          ),

                          SizedBox(width: 20),

                          // logo text
                          Text(
                            'MonkeyType Multiplayer',
                            style: TextStyle(
                              color: mytheme.inversePrimary,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(width: 20),
                        ],
                      ),

                      // left stuff
                    ],
                  ),
                  SizedBox(height: 40),

                  Container(
                    width: 700,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff2C2E31),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // main bar options ...
                      ],
                    ),
                  ),
                ],
              ), // up bar
            ),

            // // way number 1
            // Container(
            //   width: MediaQuery.of(context).size.width * .8,
            //   height: 100,
            //   color: Colors.red,
            //   child: GridView.builder(
            //     itemCount: _text.length,
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount:
            //           (MediaQuery.of(context).size.width / 30).toInt(),
            //     ),
            //     itemBuilder: (context, index) {
            //       return Container(
            //         height: 100,
            //         color: Colors.white,
            //         child: Align(
            //           alignment: Alignment.topCenter,
            //           child: Text(
            //             _text[index]['char'],
            //             style: TextStyle(
            //               color:
            //                   _text[index]['color'] == 1
            //                       ? Colors.green
            //                       : Colors.red,
            //               fontSize: 20,
            //             ),
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text((cpm / 5).toString()),
              ),
            ),

            // way number two
            Container(
              width: MediaQuery.of(context).size.width * .8,
              height: 120,
              // decoration: BoxDecoration(color: Colors.red),
              decoration: BoxDecoration(),
              clipBehavior: Clip.hardEdge,
              child: Wrap(
                children: List.generate(_words.length, (index) {
                  return Container(
                    height: 40,
                    // color: Colors.blue,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _words[index].length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, windex) {
                        final currentword = _words[index][windex];
                        return Stack(
                          children: [
                            Container(
                              child: Text(
                                currentword['char'],
                                style: TextStyle(
                                  fontSize: 30,
                                  color:
                                      ((currentword['color'] == 1
                                          ? Colors.green
                                          : (currentword['color'] == -1
                                              ? Colors.red
                                              : mytheme.inversePrimary))),
                                ),
                              ),
                            ),
                            Positioned.directional(
                              textDirection: TextDirection.ltr,
                              start: -2,
                              top: 5,
                              bottom: 5,
                              child:
                                  currentword['index'] == userIndex
                                      ? Center(
                                        child: Container(
                                          width: 5,
                                          height: 30,
                                          color: mytheme.secondary,
                                        ),
                                      )
                                      : Container(),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }),
              ),
            ),

            Container(
              width: 500,
              height: 200,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      startTimer();
                    },
                    child: Container(color: Colors.green, width: 200),
                  ),
                  GestureDetector(
                    onTap: () {
                      stopTimer();
                    },
                    child: Container(color: Colors.red, width: 200),
                  ),
                ],
              ),
            ),

            Container(
              height: 50,
              width: 50,
              color:
                  isTyping == 1
                      ? Colors.green
                      : isTyping == -1
                      ? mytheme.inversePrimary
                      : Colors.blue,
              child: Center(
                child: Text(
                  isTyping == 1
                      ? "is typing"
                      : isTyping == -1
                      ? "hasn't started yet"
                      : "has finished",
                ),
              ),
            ),

            KeyboardListener(
              focusNode: _focusNode,
              autofocus: true,
              onKeyEvent: (KeyEvent event) {
                final label = event.logicalKey.keyLabel;
                final keychar = event.character;
                if (event is KeyRepeatEvent || event is KeyDownEvent) {
                  if (keychar != null) {
                    print(keychar);
                    compare(keychar);
                  } else {
                    print(label);
                    compare(label);
                  }
                }
              },
              child: Container(),
            ),
            Container(height: 30, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
