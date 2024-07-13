import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  //giving the instance of auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //instance of firebase firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //Sign in user
  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    //trying sign in
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    //catch the error
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Create new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password, String username) async {
    //try creating a user
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      _firestore.collection('users').doc(userCredential.user!.uid).set(
          {'uid': userCredential.user!.uid, 'email': email,'username': username},
          SetOptions(merge: true));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //Sign out user
  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }
}
