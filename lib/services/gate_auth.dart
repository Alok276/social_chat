import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_chat/screens/home_page.dart';
import 'package:social_chat/services/login_or_signup.dart';


class GateAuth extends StatelessWidget {
  const GateAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const LoginOrRegister();
            }
          }),
    );
  }
}
