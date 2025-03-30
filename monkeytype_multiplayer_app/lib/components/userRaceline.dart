import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Userraceline extends StatefulWidget {
  const Userraceline({super.key});

  @override
  State<Userraceline> createState() => _UserracelineState();
}

class _UserracelineState extends State<Userraceline> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: Colors.blue),
            child: UserItem(x: 0, y: 0),
          ),
        ),
        SizedBox(width: 20),
        Text("wpm"),
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
