import 'package:flutter/material.dart';
import 'package:monkeytype_multiplayer_app/pages/home_page.dart';
import 'package:monkeytype_multiplayer_app/themes/darkMode.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MonkeyType Multiplayer',
      theme: darkMode,
      home: HomePage(),
    );
  }
}
