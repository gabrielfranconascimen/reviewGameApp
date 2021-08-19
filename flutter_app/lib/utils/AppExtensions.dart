import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'firebase/MyFirebaseFirestore.dart';

extension ConsolesTypeExtension on ConsolesType {
  String getConsoleWithType() {
    switch(this) {
      case ConsolesType.playstation:
        return "playstation";
      case ConsolesType.xbox:
        return "xbox";
      case ConsolesType.nintendo:
        return "switch";
      case ConsolesType.computer:
        return "computador";
    }
  }
}

extension BuildContextExtension on BuildContext {
  showMyDialog(String message) {
    showDialog(
        context: this,
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
}