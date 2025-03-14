import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FocusNode _focusNode = FocusNode();
  final String TypeText = "hola como estamos el dia de hoy";
  late String userText;
  int originalIndex = 0, userIndex = 0;
  late int originalSize;
  List<Map> _text = [];

  @override
  void initState() {
    // TODO: implement initState
    originalSize = TypeText.length;
    userText = TypeText;
    for (int i = 0; i < TypeText.length; i++) {
      _text.add({"char": TypeText[i], "color": 1});
    }
    super.initState();
  }

  void compare(String key) {
    setState(() {
      if (key == 'Backspace') {
        if (userIndex > originalIndex) {
          userText =
              userText.substring(0, userIndex - 1) +
              TypeText.substring(originalIndex);
          userIndex--;
        }
        return;
      }
      if (key != TypeText[originalIndex]) {
        userText =
            userText.substring(0, userIndex) +
            key +
            TypeText.substring(originalIndex);
        userIndex++;
        return;
      }
      userIndex++;
      originalIndex++;
    });
    print(TypeText);
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
            Expanded(
              child: GridView.builder(
                itemCount: _text.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 50,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    width: double.infinity,
                    child: Text(
                      _text[index]['char'],
                      style: TextStyle(
                        color:
                            _text[index]['color'] == 1
                                ? Colors.green
                                : Colors.red,
                      ),
                    ),
                  );
                },
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
