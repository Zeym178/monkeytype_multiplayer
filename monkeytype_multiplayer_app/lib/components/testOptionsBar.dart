import 'package:flutter/material.dart';
import 'package:monkeytype_multiplayer_app/components/hoverText.dart';

class Testoptionsbar extends StatefulWidget {
  final Function(String newtext) onCustom;
  const Testoptionsbar({super.key, required this.onCustom});

  @override
  State<Testoptionsbar> createState() => _TestoptionsbarState();
}

class _TestoptionsbarState extends State<Testoptionsbar> {
  final testTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return Container(
      width: 700,
      height: 40,
      decoration: BoxDecoration(
        color: Color(0xff2C2E31),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              _showDialog(context, mytheme);
            },
            child: Container(
              child: Center(child: Hovertext(text: 'custom', fontsize: 15)),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, ColorScheme mytheme) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Insert the Text you want to test')),
          content: TextField(controller: testTextController),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    testTextController.clear();
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: mytheme.primary,
                    child: Center(child: Text('Cancel')),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    widget.onCustom(testTextController.text);
                    testTextController.clear();
                    Navigator.pop(context);
                  },
                  child: Container(
                    color: mytheme.primary,
                    child: Center(child: Text('Test ..')),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
