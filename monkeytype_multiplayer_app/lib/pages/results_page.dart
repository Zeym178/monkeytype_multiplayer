import 'package:flutter/material.dart';

class ResultsPage extends StatefulWidget {
  final double cpm;
  const ResultsPage({super.key, required this.cpm});

  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  @override
  Widget build(BuildContext context) {
    final cpm = widget.cpm;
    final wpm = widget.cpm / 5;
    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: Column(
          children: [
            Center(child: Text(cpm.toString())),
            Center(child: Text(wpm.toString())),
          ],
        ),
      ),
    );
  }
}
