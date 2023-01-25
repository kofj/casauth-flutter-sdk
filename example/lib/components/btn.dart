import 'package:flutter/material.dart';

Widget maxButton(String title, Color color, Function() onPressed) {
  return ButtonBar(
    children: <Widget>[
      SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(color),
          ),
          onPressed: onPressed,
          child: Text(title),
        ),
      ),
    ],
  );
}
