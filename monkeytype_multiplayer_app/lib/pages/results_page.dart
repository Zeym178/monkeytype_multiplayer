import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  final double cpm;
  final Function togglePage;
  const ResultsPage({super.key, required this.cpm, required this.togglePage});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final cpm = widget.cpm;
    final wpm = widget.cpm / 5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(cpm.toString())),
        Center(child: Text(wpm.toString())),
      ],
    );
  }
}
