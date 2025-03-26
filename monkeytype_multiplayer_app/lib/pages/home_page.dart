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

  Cpmcontroller cpmController = Cpmcontroller();
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

    final pages = [
      SingletestPage(togglePage: togglePage, cpmcontroller: cpmController),
      ResultsPage(cpmController: cpmController, togglePage: togglePage),
      LoginRegisterPage(togglePage: togglePage, authservice: authservice),
      ProfilePage(authservice: authservice),
    ];

    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 200),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // right stuff
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap:
                              () => setState(() {
                                pageIndex = 0;
                              }),
                          child: Row(
                            children: [
                              // logo
                              Center(
                                child: SvgPicture.asset(
                                  'assets/images/app_logo.svg',
                                  height: 50,
                                  width: 50,
                                  color: mytheme.secondary,
                                ),
                              ),

                              SizedBox(width: 20),

                              // logo text
                              Text(
                                'MonkeyType Multiplayer',
                                style: TextStyle(
                                  color: mytheme.inversePrimary,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ),

                      // left stuff
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    pageIndex = 2;
                                  });
                                },
                                child: Hovericon(icon: Icons.person),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ), // up bar
            ),

            Expanded(child: pages[pageIndex]),

            Container(height: 30, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
