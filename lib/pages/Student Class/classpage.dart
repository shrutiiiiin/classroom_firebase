import 'package:authentication_flutter/components/my_drawer.dart';
import 'package:flutter/material.dart';

class ClassPage extends StatelessWidget {
  final String? studentClass;
  ClassPage({super.key, this.studentClass});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Classroom"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: MyDrawer(),
      // body: Column(
      //   children: [
      //     SizedBox(
      //       height: 15,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.only(right: 70),
      //       child: Text(
      //         "Welcome Teacher !",
      //         style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 18,
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: Row(
      //         children: [
      //           Expanded(
      //             child: myTextfield(
      //                 hintText: 'Make a New Annoucement',
      //                 obscureText: false,
      //                 controller: newPostController),
      //           ),
      //           MyPostButton(
      //             onTap: () {
      //               Postmessages(context);
      //             },
      //           ),
      //         ],
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
