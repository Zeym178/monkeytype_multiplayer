import 'package:flutter/material.dart';
import 'package:monkeytype_multiplayer_app/components/myButton.dart';
import 'package:monkeytype_multiplayer_app/layout/myFooter.dart';
import 'package:monkeytype_multiplayer_app/layout/myHeader.dart';
import 'package:monkeytype_multiplayer_app/pages/login_register_page.dart';
import 'package:monkeytype_multiplayer_app/services/authService.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userUsername = "Loading ...";
  late String userEmail = "Loading ...";
  String errorMessage = "";

  Authservice authservice = Authservice();

  void getUserData() async {
    final success = await authservice.getCurrentUser();

    if (success != null) {
      setState(() {
        userEmail = success['email'];
        userUsername = success['username'];
      });
    } else {
      setState(() {
        errorMessage = "There's was a problem fetching the data!";
      });
    }
  }

  void logOutUser() async {
    final success = await authservice.logoutUser();

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginRegisterPage()),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(userUsername),
        Text(userEmail),
        Text(errorMessage),
        Container(
          width: 300,
          height: 40,
          child: Mybutton(
            text: 'Log Out',
            onClick: () {
              logOutUser();
            },
          ),
        ),
      ],
    );
  }
}
