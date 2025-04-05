import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monkeytype_multiplayer_app/components/myButton.dart';
import 'package:monkeytype_multiplayer_app/components/myTextField.dart';
import 'package:monkeytype_multiplayer_app/layout/myFooter.dart';
import 'package:monkeytype_multiplayer_app/layout/myHeader.dart';
import 'package:monkeytype_multiplayer_app/pages/multiTest_page.dart';

class FindracePage extends StatefulWidget {
  const FindracePage({super.key});

  @override
  State<FindracePage> createState() => _FindracePageState();
}

class _FindracePageState extends State<FindracePage> {
  final roomCodeController = TextEditingController();
  final myRoomNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Myheader(),

          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * .8,
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    width: 200,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Insert the Room Code below :)",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Mytextfield(
                            textController: roomCodeController,
                            hint: "Your code in here ...",
                          ),
                        ),
                        Container(
                          height: 40,
                          child: Mybutton(text: "Enter Room", onClick: () {}),
                        ),

                        SizedBox(height: 20),

                        Text("or"),

                        SizedBox(height: 20),

                        Text(
                          "Create a room",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        Container(
                          child: Mytextfield(
                            textController: myRoomNameController,
                            hint: "Room name in here ...",
                          ),
                        ),

                        Container(
                          height: 40,
                          child: Mybutton(text: "Create Room", onClick: () {}),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.all(20),
                    width: 300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Text(
                        //   "Find a public Race!",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        Container(
                          height: 300,
                          child: Mybutton(
                            text: "Find A Public Race!",
                            onClick: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) =>
                                          MultitestPage(roomName: "public"),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Myfooter(),
        ],
      ),
    );
  }
}
