import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_chat/components/chatbox.dart';
import 'package:social_chat/services/chat_service.dart';

import '../components/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  final String recieverUsername;
  final String recieverUserId;
  const ChatPage(
      {super.key,
      required this.recieverUsername,
      required this.recieverUserId,});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;     

  void sendMessage() async {
  //only send message id if there is something to send 
  if(_messageController.text.isNotEmpty){
  await _chatService.sendMessage( 
    widget.recieverUserId,_messageController.text);
  //clear the controller after sending the message
  _messageController.clear();
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:  Colors.teal,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ClipRRect(
              child: CircleAvatar(
             child: Text(widget.recieverUsername[0].toUpperCase(), style: const TextStyle(fontSize: 20,color: Colors.teal,
             fontWeight: FontWeight.bold),),
        ),
            ),
            const SizedBox(
              width: 15,
            ),
            Text(widget.recieverUsername,style: const TextStyle(color: Colors.white),)
          ],
        ),
        actions: const [
          IconButton(onPressed: null, icon: Icon(CupertinoIcons.video_camera_solid,
          color: Colors.white,)),
          IconButton(onPressed: null, icon: Icon(Icons.add_ic_call_sharp,
          color: Colors.white,)),
          IconButton(onPressed: null, icon:Icon(Icons.more_vert,
          color: Colors.white,),),
        ],
      ),

      body: Column(children: [
       
        //message List all the messages
        Expanded(child: _buildMessagesList()),
       
       //user will input here
        _buildMessageInput()
      ]),
    );
  }
 
  //building message list
  Widget _buildMessagesList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.recieverUserId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if(snapshot.hasError){
          return Text('Error ${snapshot.error}');
        }
        if(snapshot.connectionState ==ConnectionState.waiting){
          return const Center(child:  Text('Loading.....'));
        }
        return ListView(
          children: snapshot.data!.docs
          .map((document) => _buildMessageItem(document))
          .toList(),
          
          );
      } 
    );
  }

  //build message item 
  Widget  _buildMessageItem(DocumentSnapshot document){
   Map<String ,dynamic> data = document.data() as Map<String,dynamic>;

   //align the message to the right of the sender is the current user, otherwise to the left
   var alignment = (data['senderId']== _firebaseAuth.currentUser!.uid)
   ? Alignment.centerRight
   : Alignment.centerLeft;
   
   return Container(
    alignment: alignment,
   child: Padding(
    padding: const EdgeInsets.all(8.0),
   child: Column(
    crossAxisAlignment: (data['senderId']==_firebaseAuth.currentUser!.uid)
    ? CrossAxisAlignment.end
    :CrossAxisAlignment.start,
    mainAxisAlignment: (data['senderId'] == _firebaseAuth.currentUser!.uid)
    ? MainAxisAlignment.end
    : MainAxisAlignment.start,
    children: [
      ChatBubble(message:data['message']),
    ],
   ),),);
  }

  //build messagew input
  Widget _buildMessageInput(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      Expanded(
        child: ChatBox(hintText: 'Message', messagecontroller: _messageController, obscureText: false)
      ),
      Center(
        child: IconButton(
          onPressed: sendMessage, icon: const Icon(Icons.send,
          size: 46,
          color:   Colors.teal,)),
      ),
    ],);
  }
     
    
}
