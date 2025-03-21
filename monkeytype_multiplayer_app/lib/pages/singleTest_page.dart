import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:monkeytype_multiplayer_app/controllers/cpmController.dart';
import 'package:monkeytype_multiplayer_app/pages/textSection.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
        Textsection(
          onFinish: () {
            widget.togglePage(1);
          },
          cpmController: widget.cpmcontroller,
        ),
      ],
    );
  }
}
