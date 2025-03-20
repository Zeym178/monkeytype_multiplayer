import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:monkeytype_multiplayer_app/pages/results_page.dart';
import 'package:monkeytype_multiplayer_app/pages/singleText_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIndex = 0;
  // double cpm = 0;
  final ValueNotifier<double> cpm = ValueNotifier(0.0);
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
      SingletextPage(onFinish: hasFinished, cpm: cpm),
      ResultsPage(cpm: cpm.value, togglePage: togglePage),
    ];

    return Theme(
      data: Theme.of(context),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 200),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // right stuff
                      Row(
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

                      // left stuff
                    ],
                  ),
                  SizedBox(height: 40),

                  Container(
                    width: 700,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xff2C2E31),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        // main bar options ...
                      ],
                    ),
                  ),
                ],
              ), // up bar
            ),

            Container(
              alignment: Alignment.centerLeft,
              child: ValueListenableBuilder(
                valueListenable: cpm,
                builder: (context, value, child) {
                  return Text('WPM: ' + (cpm.value / 5).toString());
                },
              ),
            ),

            Expanded(child: pages[pageIndex]),

            Container(height: 30, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
