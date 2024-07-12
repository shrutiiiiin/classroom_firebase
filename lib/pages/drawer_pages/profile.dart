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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.inversePrimary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 80,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(user?['username'] ?? 'No username'),
                  Text(user?['email'] ?? 'No email'),
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
