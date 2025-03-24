import 'package:flutter/material.dart';

class Hovericon extends StatefulWidget {
  final IconData icon;
  const Hovericon({super.key, required this.icon});

  @override
  State<Hovericon> createState() => _HovericonState();
}

class _HovericonState extends State<Hovericon> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (event) {
        setState(() {
          _isHovered = false;
        });
      },
      child: Icon(
        widget.icon,
        color: _isHovered ? mytheme.inversePrimary : mytheme.primary,
      ),
    );
  }
}
