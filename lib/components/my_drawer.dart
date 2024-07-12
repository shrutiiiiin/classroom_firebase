import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Text("Sign Out"),
                content: Text("Are you sure you want to Sign Out ?"),
                actions: [
                  TextButton(
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No",
                        style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: Column(
        children: [
          //heading
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DrawerHeader(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    "Drawer Header",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
              // home title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    "Home",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              ),
              // profile title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/profile');
                    }),
              ),
              //user title
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ListTile(
                    leading: Icon(
                      Icons.people,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    title: Text(
                      "User",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, '/user');
                    }),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
                leading: Icon(
                  Icons.logout,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  "Logout",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                onTap: () {
                  Navigator.pop(context);
                  logout(context);
                }),
          ),
        ],
      ),
    );
  }
}
