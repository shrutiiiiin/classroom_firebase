import 'package:authentication_flutter/components/my_drawer.dart';
import 'package:authentication_flutter/components/my_postbutton.dart';
import 'package:authentication_flutter/components/textfield.dart';
import 'package:authentication_flutter/database/firestore.dart';
import 'package:authentication_flutter/helper/helper_function.dart';
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
        ],
      ),
    );
  }
}
