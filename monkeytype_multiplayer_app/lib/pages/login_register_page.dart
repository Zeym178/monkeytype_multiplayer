import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:monkeytype_multiplayer_app/components/myButton.dart';
import 'package:monkeytype_multiplayer_app/components/myTextField.dart';
import 'package:monkeytype_multiplayer_app/components/textSection.dart';
import 'package:monkeytype_multiplayer_app/services/authService.dart';

class LoginRegisterPage extends StatefulWidget {
  final Function togglePage;
  final Authservice authservice;
  const LoginRegisterPage({
    super.key,
    required this.togglePage,
    required this.authservice,
  });

  @override
  State<LoginRegisterPage> createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final email2Controller = TextEditingController();
  final passwordController = TextEditingController();
  final password2Controller = TextEditingController();

  final emailLoginController = TextEditingController();
  final passwordLoginController = TextEditingController();

  String errorMessage = "";
  String errorMessageLogin = "";

  bool checkValues() {
    if (emailController.text != email2Controller.text ||
        passwordController != password2Controller) {
      setState(() {
        errorMessage = "The field are not valid";
      });
      return false;
    }

    return true;
  }

  void loginUser() async {
    final success = await widget.authservice.loginUser(
      emailLoginController.text,
      passwordLoginController.text,
    );

    if (success) {
      widget.togglePage(3);
    } else {
      setState(() {
        errorMessageLogin = "I don't know what happened";
      });
    }
  }

  void createUser() async {
    final success = await widget.authservice.registerUser(
      usernameController.text,
      emailController.text,
      passwordController.text,
    );

    if (success) {
      // you should create a controller that help if you have an account or not
      // if yes ? your data : login_register_page
      // maybe would be easier if you just create a header and a footer (might be the best option)
      widget.togglePage(0);
    } else {
      setState(() {
        errorMessage = "The field are not valid";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mytheme = Theme.of(context).colorScheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // register lol
            Container(
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Center(
                        child: Icon(
                          Icons.person_add_alt_1,
                          color: mytheme.primary,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Register",
                        style: TextStyle(
                          color: mytheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Mytextfield(
                      textController: usernameController,
                      hint: "username",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Mytextfield(
                      textController: emailController,
                      hint: "email",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Mytextfield(
                      textController: email2Controller,
                      hint: "verify email",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Mytextfield(
                      textController: passwordController,
                      hint: "password",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Mytextfield(
                      textController: password2Controller,
                      hint: "verify password",
                    ),
                  ),
                  Container(
                    height: 45,
                    child: Mybutton(
                      onClick: () {
                        createUser();
                      },
                      text: "Sign Up",
                      icon: Icons.person_add_alt_1,
                    ),
                  ),
                  Text(errorMessage),
                ],
              ),
            ),

            // login
            Container(
              width: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Center(child: Icon(Icons.person, color: mytheme.primary)),
                      SizedBox(width: 5),
                      Text(
                        "Login",
                        style: TextStyle(
                          color: mytheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Mytextfield(
                      textController: emailLoginController,
                      hint: "email",
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Mytextfield(
                      textController: passwordLoginController,
                      hint: "password",
                    ),
                  ),
                  Container(
                    height: 45,
                    child: Mybutton(
                      onClick: () {
                        loginUser();
                      },
                      text: "Log In",
                      icon: Icons.person,
                    ),
                  ),
                  Text(errorMessageLogin),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
