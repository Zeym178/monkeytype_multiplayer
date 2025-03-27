import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monkeytype_multiplayer_app/components/hoverIcon.dart';
import 'package:monkeytype_multiplayer_app/controllers/cpmController.dart';
import 'package:monkeytype_multiplayer_app/pages/login_register_page.dart';
import 'package:monkeytype_multiplayer_app/pages/profile_page.dart';
import 'package:monkeytype_multiplayer_app/pages/results_page.dart';
import 'package:monkeytype_multiplayer_app/pages/singleTest_page.dart';
import 'package:monkeytype_multiplayer_app/services/authService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  // double cpm = 0;
  // final ValueNotifier<double> cpm = ValueNotifier(0.0);
  Authservice authservice = Authservice();

  void togglePage(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  void hasFinished() {
    setState(() {
      pageIndex = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;

    final pages = [LoginRegisterPage(), ProfilePage()];

    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Expanded(child: pages[pageIndex]),

            // THIS PAGE IS OLD, IT'S GONNA RETIRE
            Expanded(child: SingletestPage()),

            Container(height: 30, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
