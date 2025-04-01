import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Userraceline extends StatefulWidget {
  final double percentage;
  final double wpm;
  const Userraceline({super.key, required this.percentage, required this.wpm});

  @override
  State<Userraceline> createState() => _UserracelineState();
}

class _UserracelineState extends State<Userraceline> {
  late final double _x;
  late final double _wpm;

  @override
  void initState() {
    // TODO: implement initState
    _x = (widget.percentage * 2 / 100) - 1;

    int aux = (widget.wpm * 100).toInt();
    _wpm = aux.toDouble() / 100;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.blue),
            child: UserItem(x: _x, y: 0),
          ),
        ),
        SizedBox(width: 20),
        SizedBox(width: 50, child: Text(_wpm.toString())),
      ],
    );
  }
}

class UserItem extends StatelessWidget {
  final double x;
  final double y;
  const UserItem({super.key, required this.x, required this.y});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x, y),
      child: Container(
        height: 20,
        width: 20,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
      ),
    );
  }
}
