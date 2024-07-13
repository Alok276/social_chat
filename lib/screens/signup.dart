import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/components/button.dart';
import 'package:social_chat/components/text_edit.dart';
import 'package:social_chat/services/auth_services.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;
  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final usernameController = TextEditingController();

  void signUp() async {
    //confirmation of passwords
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return;
    }
    
    //get auth service
    final authService = Provider.of<AuthService>(context, listen: false);
      
    try {
      await authService.signUpWithEmailandPassword(emailController.text, passwordController.text, usernameController.text);

     } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
        SnackBar(content: Text(e.toString()));
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return   Scaffold(

body: Padding(
  padding: const EdgeInsets.all(32.0),
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    
          //create account -- heading
          const Text(
                      "Create Account",
                      style: TextStyle(
                          color: Color.fromARGB(255, 61, 57, 175),
                          fontSize: 32,
                          fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
             
         //username
        TextEdit(
                        hintText: 'username',
                        obscureText: false,
                        textEditingController: usernameController),
        
        const SizedBox(
                      height: 30,
                    ),
        //email address
        TextEdit(
                        hintText: 'Email',
                        obscureText: false,
                        textEditingController: emailController),
        const SizedBox(
                      height: 30,
                    ),
  
        //password
        TextEdit(
                        hintText: 'password',
                        obscureText: true,
                        textEditingController: passwordController),
        const SizedBox(
                      height: 30,
                    ),
  
        //confirm password
        TextEdit(
                        hintText: 'Confirm Password',
                        obscureText: true,
                        textEditingController: confirmPasswordController),
        //sign_up button
                    const SizedBox(
                      height: 30,
                    ),
                     MyButton(
                      text: "Next",   //"Sign Up",
                      onTap: signUp,
                    ),
         const SizedBox(
                      height: 30,
                    ),
        
         //Already a user signIn
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text("Already a User?"),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Sign in",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ])
          
        
     ]),
) );
  }
}