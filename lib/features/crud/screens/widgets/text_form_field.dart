import 'package:flutter/material.dart';

Widget customTextFormField(String text, TextEditingController controller) {
  return TextFormField(
    style: const TextStyle(fontSize: 14.0, color: Colors.deepPurple),
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black38)),
      focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
      contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0),
      labelText: text,
    ),
  );
}
