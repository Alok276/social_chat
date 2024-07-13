import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_chat/components/edit_dialog.dart';
import 'package:social_chat/services/auth_services.dart';
import 'package:social_chat/services/gate_auth.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({
    super.key,
  });

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  //getting the instance of auth
// FirebaseeU _auth = FirebaseAuth.instance.currentUser;
// !.uid;

  // Return an empty string if user is not authenticated

  //sign out the user
  void signOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.signOut();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => const GateAuth())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.teal,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          title: const Text("My Profile", style: TextStyle(color:  Colors.white),),
          actions: [
            IconButton(onPressed: signOut, icon: const Icon(Icons.logout, color:  Colors.white,))
          ],
        ),
        body: myProfile(context));
  }

  Widget myProfile(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    final user = FirebaseAuth.instance.currentUser;
    String uid = user?.uid ?? '1';

    return FutureBuilder<DocumentSnapshot>(
        future: users.doc(uid).get(),
        builder: (BuildContext futureBuildContext,
            AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Builder(builder: (context) {
              return SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      width: 150,
                      height: 150,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          
                          child: CircleAvatar(
                            
             child: Text(data['username'][0].toUpperCase(), style: const TextStyle(fontSize: 60,color: Colors.teal,
             fontWeight: FontWeight.bold),),
        ),
                          ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                      width: 340,
                      height: 300,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.teal
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          //Column for name of the details of the user
                          const Column(
                            children: [
                              SizedBox(height: 15, width: 100),
                              Text(
                                'Username |',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 30,
                                width: 50,
                              ),
                              Text(
                                'Email          |',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'Phone        |',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                height: 30,
                                width: 100,
                              ),
                              Text(
                                'About me   |',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          //Column for details of the user
                          Column(
                            children: [
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                data['username'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                height: 30,
                                width: 50,
                              ),
                              Text(
                                data['email'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 30, width: 20,),
                          const   Text('N/A',
                            style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.white),),
                            ],
                          ),
                          //Column for tapping the edit icon button and edtiting the corresponding details
                          Column(children: [
                            // SizedBox(height: 5,),
                            //update the username
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const EditDialog(hinttext: 'username');
                                      });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                )),
                            //SizedBox(height: 10,),
                            //update the email in database and in authentication service
                            IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const EditDialog(hinttext: 'email');
                                      });
                                },
                                icon:const  Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                  size: 18,
                                )),
                                
                          ])
                        ],
                      )
                      
                      ),
                ]),
              );
            });
          }
          return const Center(child: Text('loading'));
        });
  }
}
