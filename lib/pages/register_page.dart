import 'package:authentication_flutter/components/button.dart';
import 'package:authentication_flutter/components/textfield.dart';
import 'package:authentication_flutter/helper/helper_function.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, this.onTap});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmpasswordController =
      TextEditingController();

  Future<void> register() async {
    //added a circularprogress indicator
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
    //pop if passwords are not same

    if (passwordController.text != confirmpasswordController.text) {
      Navigator.pop(context);
      displaymessagetouser("Passwords don't match", context);
    }
    //try to register
    else {
      try {
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
        createUserDocument(userCredential);
        if (context.mounted) Navigator.pop(context);
        displaymessagetouser("Account created successfully", context);
      } on FirebaseAuthException catch (e) {
        displaymessagetouser(e.message.toString(), context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential userCredential) async {
    if (userCredential.user != null && userCredential != null) {
      try {
        await FirebaseFirestore.instance
            .collection("users")
            .doc(userCredential.user!.email)
            .set({
          'email': userCredential.user!.email,
          'username': usernameController.text
        });
      } catch (e) {
        // Handle Firestore error
        print("Failed to create user document: $e");
      }
    } else {
      print("UserCredential or User is null");
    }
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
                "R E G I S T E R",
                style: TextStyle(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontFamily:
                        Theme.of(context).textTheme.bodyMedium?.fontFamily,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              myTextfield(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController),
              SizedBox(height: 10),
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
              myTextfield(
                  hintText: " Confirm Password",
                  obscureText: true,
                  controller: confirmpasswordController),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot Password",
                    style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context)
                            .colorScheme
                            .inversePrimary
                            .withOpacity(0.5699999928474426)),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              MyButton(text: 'Register', onTap: register),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      "Login Here",
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
