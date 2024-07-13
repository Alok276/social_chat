import 'package:flutter/material.dart';
import 'package:social_chat/screens/login.dart';
import 'package:social_chat/screens/signup.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login and signup page
  void togglepages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(onTap: togglepages);
    } else {
      return SignUp(onTap: togglepages);
    }
  }
}
