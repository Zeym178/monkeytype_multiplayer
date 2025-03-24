import 'package:flutter/material.dart';

class Mytextfield extends StatefulWidget {
  final String hint;
  final TextEditingController textController;
  const Mytextfield({
    super.key,
    required this.textController,
    required this.hint,
  });

  @override
  State<Mytextfield> createState() => _MytextfieldState();
}

class _MytextfieldState extends State<Mytextfield> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    widget.textController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    print(mytheme.inversePrimary);
    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: Color(0xff2C2E31),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: widget.textController,
        cursorColor: mytheme.secondary,
        cursorHeight: 18,
        cursorWidth: 1,
        style: TextStyle(color: mytheme.inversePrimary),
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: TextStyle(color: mytheme.primary),
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 1),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mytheme.inversePrimary, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
