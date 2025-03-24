import 'package:flutter/material.dart';

class Mybutton extends StatefulWidget {
  final IconData? icon;
  final String text;
  final Function onClick;
  const Mybutton({
    super.key,
    this.icon,
    required this.text,
    required this.onClick,
  });

  @override
  State<Mybutton> createState() => _MybuttonState();
}

class _MybuttonState extends State<Mybutton> {
  bool _isHovered = false;
  Color ihatethiscolor = Color(0xff2C2E31);

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
      child: GestureDetector(
        onTap: () {
          widget.onClick();
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            color: _isHovered ? mytheme.inversePrimary : ihatethiscolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  widget.icon != null
                      ? [
                        Icon(
                          widget.icon,
                          color: _isHovered ? ihatethiscolor : mytheme.primary,
                        ),
                        SizedBox(width: 5),
                        Text(
                          widget.text,
                          style: TextStyle(
                            color:
                                _isHovered ? ihatethiscolor : mytheme.primary,
                          ),
                        ),
                      ]
                      : [
                        Text(
                          widget.text,
                          style: TextStyle(
                            color:
                                _isHovered
                                    ? mytheme.primary
                                    : mytheme.inversePrimary,
                          ),
                        ),
                      ],
            ),
          ),
        ),
      ),
    );
  }
}
