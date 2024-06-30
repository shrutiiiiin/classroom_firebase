import 'package:authentication_flutter/auth/auth.dart';
import 'package:authentication_flutter/auth/login_register.dart';
import 'package:authentication_flutter/firebase_options.dart';
import 'package:authentication_flutter/pages/drawer_pages/profile.dart';
import 'package:authentication_flutter/pages/drawer_pages/user.dart';
import 'package:authentication_flutter/pages/home_page.dart';
import 'package:authentication_flutter/theme/dark_mode.dart';
import 'package:authentication_flutter/theme/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/login_register': (context) => LoginRegister(),
        '/home_page': (context) => Homepage(),
        '/profile': (context) => ProfilePage(),
        '/user': (context)=> UserPage(),
       
      },
    );
  }
}
