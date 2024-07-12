import 'package:authentication_flutter/components/my_drawer.dart';
import 'package:authentication_flutter/components/my_postbutton.dart';
import 'package:authentication_flutter/components/textfield.dart';
import 'package:authentication_flutter/database/firestore.dart';
import 'package:authentication_flutter/helper/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  final FirestoreDatabase database = FirestoreDatabase();
  final TextEditingController newPostController = TextEditingController();

  void Postmessages(BuildContext context) async {
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      try {
        await database.addPost(message);
        newPostController.clear();
        displaymessagetouser('Posted!', context);
      } catch (e) {
        displaymessagetouser('Failed to post: $e', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classroom"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70),
            child: Text(
              "Welcome Teacher !",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: myTextfield(
                      hintText: 'Make a New Annoucement',
                      obscureText: false,
                      controller: newPostController),
                ),
                MyPostButton(
                  onTap: () {
                    Postmessages(context);
                  },
                ),
              ],
            ),
          ),
          StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final posts = snapshot.data!.docs;
                if (snapshot.hasError) {
                  displaymessagetouser('Something went wrong', context);
                } else if (snapshot.hasData == null || posts.isEmpty) {
                  return Center(
                      child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      "No data, Post something",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ));
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      String message = post['message'];
                      String userEmail = post['user'];
                      Timestamp timestamp = post['timestamp'];
                      return ListTile(
                        title: Text(post['message']),
                        subtitle: Text(post['user']),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
