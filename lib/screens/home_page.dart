import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_chat/screens/chat_page.dart';
import 'package:social_chat/screens/my_profile.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.white,
      appBar: AppBar(
        elevation: 4.0,
        
        backgroundColor: Colors.teal,
        title: const Text("Chats", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  const MyProfile()));
              },
              icon: const Icon(Icons.person, color:  Colors.white,)),
        ],
      ),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text('Error');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child:  CircularProgressIndicator());
          }
          return ListView(
              children: snapshot.data!.docs
                  .map<Widget>((doc) => _buildUserListItem(doc))
                  .toList(),);
        });
  }

  //build individual user list Item
  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    //display all users except current
    if (_auth.currentUser!.email != data['email']) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
        
          leading:  CircleAvatar(
            backgroundColor: Colors.teal,
               child: Text(data['username'][0].toUpperCase(), style: const TextStyle(fontSize: 20,color: Colors.white),),
          ),
          
          title:  Text(data['username'].toUpperCase(),
          style: const TextStyle( 
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.normal
          ),),
          
        
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) =>  ChatPage(
                  recieverUsername: data['username'],
                  recieverUserId: data['uid'],
                )));
          },
        ),
      );
    } else {
      return Container();
    }
  }
}
