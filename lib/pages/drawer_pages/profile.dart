import 'package:authentication_flutter/components/my_backbutton.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    // Get the current user
    // Check if user is signed in
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.email) // Using email as the document ID
        .get();

    // Get the user's document from Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic>? user = snapshot.data?.data();

            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 50),
                    child: Row(
                      children: [
                        MyBackbutton(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    user?['username'] ?? 'No username',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user?['email'] ?? 'No email',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text("Has no data"),
            );
          }
        },
      ),
    );
  }
}
