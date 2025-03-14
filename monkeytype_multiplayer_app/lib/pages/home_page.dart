import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;

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
              margin: EdgeInsets.all(50),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      color: Colors.red,
                      child: TextField(
                        style: TextStyle(fontSize: 20),
                        decoration: InputDecoration(hintText: 'I suck :('),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      color: Colors.grey.withOpacity(.3),
                      child: TextField(style: TextStyle(fontSize: 20)),
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 30, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
