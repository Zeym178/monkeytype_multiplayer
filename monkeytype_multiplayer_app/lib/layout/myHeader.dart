import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:monkeytype_multiplayer_app/components/hoverIcon.dart';
import 'package:monkeytype_multiplayer_app/components/myButton.dart';
import 'package:monkeytype_multiplayer_app/helpers/authHelper.dart';
import 'package:monkeytype_multiplayer_app/pages/findRace_page.dart';
import 'package:monkeytype_multiplayer_app/pages/login_register_page.dart';
import 'package:monkeytype_multiplayer_app/pages/multiTest_page.dart';
import 'package:monkeytype_multiplayer_app/pages/singleTest_page.dart';
import 'package:monkeytype_multiplayer_app/services/authService.dart';

class Myheader extends StatefulWidget {
  const Myheader({super.key});

  @override
  State<Myheader> createState() => _MyheaderState();
}

class _MyheaderState extends State<Myheader> {
  Authservice authservice = Authservice();

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
                        Navigator.pushReplacement(
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
                  // multiplayer button (improvable)
                  FutureBuilder(
                    future: authservice.isLoggedIn(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (snapshot.hasData && snapshot.data != null) {
                        final isLoggedin = snapshot.data!;
                        return Visibility(
                          visible: isLoggedin,
                          child: Container(
                            height: 40,
                            width: 100,
                            child: Mybutton(
                              text: "Try a Race !",
                              onClick: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    // builder: (context) => MultitestPage(),
                                    builder: (context) => FindracePage(),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      }

                      return Center(child: Icon(Icons.error));
                    },
                  ),

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
