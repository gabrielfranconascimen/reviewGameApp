import 'package:flutter/material.dart';

showMyDialog(BuildContext context, String message) {
  showDialog(
      context: context,
      builder: (BuildContext context) =>
          AlertDialog(
            title: const Text("Atenção"),
            content: Text(message),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context, 'Ok'),
                  child: const Text("Ok"))
            ],
          ));
}