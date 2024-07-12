import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FirestoreDatabase {
  final User? user = FirebaseAuth.instance.currentUser;

  // Get the user's document from Firestore
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  Future<DocumentReference<Map<String, dynamic>>> addPost(
      String message) async {
    // Get the current user
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw FirebaseAuthException(
        code: 'user-not-signed-in',
        message: 'No user is currently signed in.',
      );
    }

    return FirebaseFirestore.instance.collection('posts').add({
      'message': message,
      'user': currentUser.email,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getPostsStream() {
    final postStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('timestamp', descending: true)
        .snapshots();
    return postStream;
  }
}
