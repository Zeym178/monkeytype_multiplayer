import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Userraceline extends StatefulWidget {
  final double cpm;
  const Userraceline({super.key, required this.cpm});

  @override
  State<Userraceline> createState() => _UserracelineState();
}

class _UserracelineState extends State<Userraceline> {
  double x = 0, y = 0;

  void updatePos(double nx, double ny) {
    setState(() {
      x = nx;
      y = ny;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 20,
        width: 20,
        alignment: Alignment(x, y),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red,
        ),
      ),
    );
  }
}
