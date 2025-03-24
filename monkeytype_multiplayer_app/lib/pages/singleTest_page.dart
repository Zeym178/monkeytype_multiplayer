import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/state_manager.dart';
import 'package:monkeytype_multiplayer_app/components/testOptionsBar.dart';
import 'package:monkeytype_multiplayer_app/controllers/cpmController.dart';
import 'package:monkeytype_multiplayer_app/components/textSection.dart';

class SingletestPage extends StatefulWidget {
  final Cpmcontroller cpmcontroller;
  final Function togglePage;
  const SingletestPage({
    super.key,
    required this.togglePage,
    required this.cpmcontroller,
  });

  @override
  State<SingletestPage> createState() => _SingletestPageState();
}

class _SingletestPageState extends State<SingletestPage> {
  String testText = "hola como estas";
  @override
  void initState() {
    // TODO: implement initState
    widget.cpmcontroller.clearController();
    super.initState();
  }

  void updateText(String newtext) {
    setState(() {
      widget.cpmcontroller.clearController();
      testText = newtext;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Testoptionsbar(onCustom: updateText),
        SizedBox(height: 40),
        Container(
          width: MediaQuery.of(context).size.width * .8,
          alignment: Alignment.centerLeft,
          child: Obx(() {
            return Center(
              child: Text(
                'WPM: ' + (widget.cpmcontroller.cpm.value / 5).toString(),
              ),
            );
          }),
        ),
        Container(
          child: Textsection(
            key: UniqueKey(),
            onFinish: () {
              widget.togglePage(1);
            },
            testText: testText,
            cpmController: widget.cpmcontroller,
          ),
        ),
      ],
    );
  }
}
