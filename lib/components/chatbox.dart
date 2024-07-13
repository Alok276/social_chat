import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final String hintText;
  final TextEditingController messagecontroller;
  final bool obscureText;
  const ChatBox(
      {super.key,
      required this.hintText,
      required this.messagecontroller,
      required this.obscureText,});

  @override
  Widget build(BuildContext context) {
    return 
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          
          cursorColor: Colors.teal,
          obscureText: obscureText,
          controller: messagecontroller,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(
                  color:  Colors.teal,
                  width: 2.5
                )),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
                borderSide: BorderSide(
                  color:  Colors.teal,
                  width: 2.5
                )),
            fillColor: Colors.grey[200],
            filled: true,
            hintText: hintText,
            
            hintStyle: const TextStyle(color: Colors.teal),
          ),
        ),
      );
  }
}
