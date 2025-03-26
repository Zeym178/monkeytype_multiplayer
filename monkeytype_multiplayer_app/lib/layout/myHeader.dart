import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:monkeytype_multiplayer_app/components/hoverIcon.dart';
import 'package:monkeytype_multiplayer_app/helpers/authHelper.dart';
import 'package:monkeytype_multiplayer_app/pages/login_register_page.dart';
import 'package:monkeytype_multiplayer_app/pages/singleTest_page.dart';

class Myheader extends StatefulWidget {
  const Myheader({super.key});

  @override
  State<Myheader> createState() => _MyheaderState();
}

class _MyheaderState extends State<Myheader> {
  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 200),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // left stuff
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap:
                      () => setState(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SingletestPage(),
                          ),
                        );
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

              // right stuff
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Authhelper(),
                              ),
                            );
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
    );
  }
}
