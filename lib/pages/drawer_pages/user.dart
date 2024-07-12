import 'package:authentication_flutter/components/my_backbutton.dart';
import 'package:authentication_flutter/components/my_listTile.dart';
import 'package:authentication_flutter/helper/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            displaymessagetouser('Something went wrong', context);
          }
          if (snapshot.hasData == null) {
            return Text("No data");
          }
          final users = snapshot.data!.docs;
          //List<DocumentSnapshot> users = snapshot.data!.docs;

          return Column(
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
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: users.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return MyListtile(
                        subtitle: user['email'], title: user['username']);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
