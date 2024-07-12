import 'package:authentication_flutter/components/button.dart';
import 'package:authentication_flutter/components/textfield.dart';
import 'package:authentication_flutter/helper/helper_function.dart';
import 'package:authentication_flutter/pages/Student%20Class/classpage.dart';
import 'package:authentication_flutter/pages/home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  String? userType;
  String? studentClass;

  login() async {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      if (context.mounted) Navigator.pop(context);
      displaymessagetouser("Login Successful", context);
      if (userType == 'Student') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ClassPage()));
      } else if (userType == 'Teacher') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Homepage()));
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      displaymessagetouser(e.message.toString(), context);
    }
    //try sign in
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(
            child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                "L O G I N",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontFamily:
                        Theme.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              myTextfield(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController),
              SizedBox(height: 10),
              myTextfield(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController),
              SizedBox(
                height: 5,
              ),
              DropdownButton<String>(
                value: userType,
                hint: Text("Select User Type"),
                onChanged: (String? newValue) {
                  setState(() {
                    userType = newValue!;
                    studentClass =
                        null; // Reset class selection when user type changes
                  });
                },
                items: <String>['Student', 'Teacher']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              if (userType == 'Student') ...[
                DropdownButton<String>(
                  value: studentClass,
                  hint: Text("Select Class"),
                  onChanged: (String? newValue) {
                    setState(() {
                      studentClass = newValue!;
                    });
                  },
                  items: <String>[
                    'Class 1',
                    'Class 2',
                    'Class 3',
                    'Class 4',
                    'Class 5',
                    'Class 6',
                    'Class 7',
                    'Class 8',
                    'Class 9',
                    'Class 10'
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(color: Colors.black.withOpacity(0.6555)),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              MyButton(text: 'Sign in', onTap: login),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Register Here",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  )
                ],
              )
            ]),
          ),
        )));
  }
}
