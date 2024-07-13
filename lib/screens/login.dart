import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/components/button.dart';
import 'package:social_chat/components/text_edit.dart';
import 'package:social_chat/services/auth_services.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

final emailController = TextEditingController();
  final passwordController = TextEditingController();

   void signIn() async {
    //get the auth service
    final authService = Provider.of<AuthService>(context, listen: false);
    try {
      await authService.signInWithEmailandPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      if (context.mounted) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          e.toString(),
        )));
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          //logo
           FractionallySizedBox(
                              widthFactor: 0.5,
                              child: Image.asset(
                                "assets/images/login.png",
                                fit: BoxFit.cover,
                              )),
            const SizedBox(
                            height: 15,
                          ),
          //welcome text                  
                          const Text(
                            "Welcome",
                            style: TextStyle(
                                color: Color.fromARGB(255, 61, 57, 175),
                                fontSize: 25,
                                fontWeight: FontWeight.w800),
                          ),
                           const SizedBox(
                            height: 20,
                          ),
          
        
          //email
          TextEdit(
                              hintText: "Email",
                              obscureText: false,
                              textEditingController: emailController),
          const SizedBox(
                            height: 15,
                          ),
          
        
          //password
           TextEdit(
                              hintText: "Password",
                              obscureText: true,
                              textEditingController: passwordController),
                         
                          const SizedBox(
                            height: 30,
                          ),
        
          //signIn Button
            MyButton(
                            text: "Sign in",
                            onTap: signIn,
                          ),
          
                          const SizedBox(
                            height: 10,
                          ),
        
          //New user
          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("New User?"),
                                GestureDetector(
                                  onTap: widget.onTap,
                                  child: const Text(
                                    "Create Account",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )
                              ]),
                          const SizedBox(
                            height: 40,
                          ),
        
          //Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Forgot Password?"),
                              GestureDetector(
                                onTap: (){},
                                  child: const Text(
                                    " Click here",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  )),
                            ],
                          )
        
        
             ] ),
      ),
    );
  }
}