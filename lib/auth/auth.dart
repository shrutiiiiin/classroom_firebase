import 'package:authentication_flutter/auth/login_register.dart';
import 'package:authentication_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if user is signed in
          if (snapshot.hasData) {
            return Homepage();
          }
          //if user is not signed in
          else {
            return LoginRegister();
          }
        },
      ),
    );
  }
}
