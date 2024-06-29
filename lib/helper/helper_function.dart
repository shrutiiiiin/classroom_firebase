import 'package:flutter/material.dart';

void displaymessagetouser(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
              title: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          )));
}
