import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class EditDialog extends StatefulWidget {
  final String hinttext;
  const EditDialog({super.key, required this.hinttext});

  @override
  State<EditDialog> createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _textEditingController = TextEditingController();
  void updateDetails() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        if (widget.hinttext == 'email') {
          await user.verifyBeforeUpdateEmail(_textEditingController.text);
        }

        ///new code
        // Update the email in the user's document
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          widget.hinttext: _textEditingController.text
          //'email': emailController.text,
          // You can add more fields as needed
        });
        if (!mounted) return; {
          Navigator.of(context).pop();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${widget.hinttext} updated Successfully')));
        }
      }
    } catch (error) {
      if (!mounted)  return; {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('An error occured: $error')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(hintText: widget.hinttext),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                            onPressed: updateDetails, child: const Text('Save'))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
