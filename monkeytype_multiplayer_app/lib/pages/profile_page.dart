import 'package:flutter/material.dart';
import 'package:monkeytype_multiplayer_app/services/authService.dart';

class ProfilePage extends StatefulWidget {
  final Authservice authservice;
  const ProfilePage({super.key, required this.authservice});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String userUsername = "Loading ...";
  late String userEmail = "Loading ...";
  String errorMessage = "";

  void getUserData() async {
    final success = await widget.authservice.getCurrentUser();

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
      children: [Text(userUsername), Text(userEmail), Text(errorMessage)],
    );
  }
}
