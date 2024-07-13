import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_chat/components/messages.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String recieverID, String message) async {
    //get current user info
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    final String currentUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timeStamp = Timestamp.now();

    //create new message
    Message newMessage = Message(
        message: message,
        recieverId: recieverID,
        senderEmail: currentUserEmail,
        senderId: currentUserId,
        timestamp: timeStamp);
    //construct a chat room id from the current user and reciever id
    List<String> ids = [currentUserId, recieverID];
    ids.sort();
    //combining the chat room ids into the single ids to use a chatroom id
    String chatRoomId = ids.join('_');

    //add a new message to database
    await _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    return _firestore
        .collection('chat_room')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
