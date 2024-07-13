import 'package:flutter/material.dart';

class TextEdit extends StatelessWidget {
 final String hintText;
 final TextEditingController textEditingController;
  final bool obscureText;

  const TextEdit({super.key,
   required this.hintText,
   required this.obscureText,
   required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: textEditingController,
      decoration:  InputDecoration(
        
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 61, 57, 175),)
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    borderSide: BorderSide(color: Color.fromARGB(255, 61, 57, 175),)
                  ),
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.grey),

                ),
    );
  }
}
