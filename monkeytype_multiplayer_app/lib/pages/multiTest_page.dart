import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:monkeytype_multiplayer_app/components/textSection.dart';
import 'package:monkeytype_multiplayer_app/controllers/cpmController.dart';
import 'package:monkeytype_multiplayer_app/controllers/multiplayerController.dart';
import 'package:monkeytype_multiplayer_app/layout/myFooter.dart';
import 'package:monkeytype_multiplayer_app/layout/myHeader.dart';
import 'package:monkeytype_multiplayer_app/services/multiplayerService.dart';

class MultitestPage extends StatefulWidget {
  const MultitestPage({super.key});

  @override
  State<MultitestPage> createState() => _MultitestPageState();
}

class _MultitestPageState extends State<MultitestPage> {
  Multiplayercontroller multiplayercontroller = Multiplayercontroller();
  late Multiplayerservice multiplayerservice;
  Cpmcontroller cpmcontroller = Cpmcontroller();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // connection to the websocket (maybe give it our username / email)
    // by now just the websocket id so we can handle it easier and we can test (hello)
    multiplayerservice = Multiplayerservice(multiplayercontroller);
    multiplayerservice.startConnection();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    multiplayerservice.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Myheader(),
          Obx(
            () => Text(
              "Users Connected: ${multiplayercontroller.usersConnected.value}",
            ),
          ),
          Text("You're in a race !"),
          Obx(
            () => Text("Other's cpm: ${multiplayercontroller.otherCpm.value}"),
          ),
          Textsection(
            multiplayerservice: multiplayerservice,
            onFinish: () {},
            cpmController: cpmcontroller,
            testText: "hola amiguitos como estamos",
          ),
          Myfooter(),
        ],
      ),
    );
  }
}
