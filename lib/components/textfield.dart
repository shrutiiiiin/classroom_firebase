import 'package:flutter/material.dart';

class myTextfield extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  myTextfield(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: Theme.of(context).colorScheme.inversePrimary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .inversePrimary
                .withOpacity(0.4564744784)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .inversePrimary
                  .withOpacity(0.3999999999)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
              color: Theme.of(context).colorScheme.inversePrimary, width: 2),
        ),
      ),
      style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
    );
  }
}
