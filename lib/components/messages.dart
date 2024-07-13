import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderId;
  final String senderEmail;
  final String recieverId;
  final String message;
  final Timestamp timestamp;

  Message(
      {required this.message,
      required this.recieverId,
      required this.senderEmail,
      required this.senderId,
      required this.timestamp});
  //convert to a map
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recieverId': recieverId,
      'message': message,
      'timestamp': timestamp
    };
  }
}
