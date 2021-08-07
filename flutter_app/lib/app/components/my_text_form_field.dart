import 'package:flutter/material.dart';
import 'package:flutter_app/utils/AppDimens.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController textController;
  final String hint;
  final bool isObscureText;
  final TextInputType? keyboardType;

  MyTextFormField({
    required this.textController,
    required this.hint,
    this.isObscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: AppDimens.xMediumMargin,
        left: AppDimens.xMediumMargin,
        top: AppDimens.sMediumMargin,
      ),
      child: TextField(
        keyboardType: keyboardType,
        controller: textController,
        obscureText: isObscureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: hint,
        ),
      ),
    );
  }
}
