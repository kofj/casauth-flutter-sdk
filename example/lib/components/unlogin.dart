import 'dart:developer';

import 'package:flutter/material.dart';

class Unlogin extends StatefulWidget {
  final Function() notifyParent;
  const Unlogin({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<Unlogin> createState() => _UnloginState();
}

class _UnloginState extends State<Unlogin> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, "/login").then((value) {
            log("update home page state, callback value: $value");
            widget.notifyParent();
          });
        },
        child: const Text("Login"),
      ),
      const SizedBox(
        height: 130,
      ),
      TextButton(
        onPressed: () {
          // Navigator.pushNamed(context, "/signup");
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black54),
        ),
        child: const Text('New User? Create Account'),
      ),
    ]);
  }
}
