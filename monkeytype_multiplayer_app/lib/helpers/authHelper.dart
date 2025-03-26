import 'package:flutter/material.dart';
import 'package:monkeytype_multiplayer_app/layout/myFooter.dart';
import 'package:monkeytype_multiplayer_app/layout/myHeader.dart';
import 'package:monkeytype_multiplayer_app/pages/login_register_page.dart';
import 'package:monkeytype_multiplayer_app/pages/profile_page.dart';
import 'package:monkeytype_multiplayer_app/services/authService.dart';

class Authhelper extends StatefulWidget {
  const Authhelper({super.key});

  @override
  State<Authhelper> createState() => _AuthhelperState();
}

class _AuthhelperState extends State<Authhelper> {
  Authservice authservice = Authservice();

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Myheader(),

          Expanded(
            child: FutureBuilder(
              future: authservice.isLoggedIn(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                // NOTE FROM THE PAST: you can consider using just a navigator in here
                // since there's no problem on privacy, because in the profilepage
                // we load the user data from another call to the server, so it's ok (I hope)

                if (snapshot.hasData && snapshot.data != null) {
                  final bool _isLoggedIn = snapshot.data!;
                  if (_isLoggedIn) {
                    return ProfilePage();
                  } else {
                    return LoginRegisterPage();
                  }
                }

                return Center(child: Icon(Icons.error));
              },
            ),
          ),

          Myfooter(),
        ],
      ),
    );
  }
}
