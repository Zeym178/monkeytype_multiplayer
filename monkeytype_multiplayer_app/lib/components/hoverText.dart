import 'package:flutter/material.dart';

class Hovertext extends StatefulWidget {
  final String text;
  final double fontsize;
  const Hovertext({super.key, required this.text, required this.fontsize});

  @override
  State<Hovertext> createState() => _HovertextState();
}

class _HovertextState extends State<Hovertext> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter:
          (event) => setState(() {
            _isHovered = true;
          }),
      onExit:
          (event) => setState(() {
            _isHovered = false;
          }),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: widget.fontsize,
          color: _isHovered ? mytheme.inversePrimary : mytheme.primary,
        ),
      ),
    );
  }
}
