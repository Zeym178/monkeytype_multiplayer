import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:monkeytype_multiplayer_app/components/testOptionsBar.dart';
import 'package:monkeytype_multiplayer_app/controllers/cpmController.dart';
import 'package:monkeytype_multiplayer_app/components/textSection.dart';
import 'package:monkeytype_multiplayer_app/layout/myFooter.dart';
import 'package:monkeytype_multiplayer_app/layout/myHeader.dart';
import 'package:monkeytype_multiplayer_app/pages/results_page.dart';

class SingletestPage extends StatefulWidget {
  const SingletestPage({super.key});

  @override
  State<SingletestPage> createState() => _SingletestPageState();
}

class _SingletestPageState extends State<SingletestPage> {
  Cpmcontroller cpmController = Cpmcontroller();
  String testText = "hola como estas";

  @override
  void initState() {
    // TODO: implement initState
    cpmController.clearController();
    super.initState();
  }

  void updateText(String newtext) {
    setState(() {
      cpmController.clearController();
      testText = newtext;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Myheader(),

          Testoptionsbar(onCustom: updateText),
          SizedBox(height: 40),
          Container(
            width: MediaQuery.of(context).size.width * .8,
            alignment: Alignment.centerLeft,
            child: Obx(() {
              return Center(
                child: Text('WPM: ' + (cpmController.cpm.value / 5).toString()),
              );
            }),
          ),
          Expanded(
            child: Textsection(
              key: UniqueKey(),
              onFinish: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => ResultsPage(cpmController: cpmController),
                  ),
                );
              },
              testText: testText,
              cpmController: cpmController,
            ),
          ),

          Myfooter(),
        ],
      ),
    );
  }
}
