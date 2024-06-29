import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: Column(
        children: [
          //heading
          DrawerHeader(
            child: Text(
              "Drawer Header",
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
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
              title: Text("Home"),
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
              title: Text("Profile"),
              onTap: () => Navigator.pop(context),
            ),
          ),
          //user title
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: Text("Home"),
              onTap: () => Navigator.pop(context),
            ),
          )
        ],
      ),
    );
  }
}
