import 'dart:developer';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:colored_json/colored_json.dart';
import 'package:casauth/client.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class LogedIn extends StatefulWidget {
  final Function() notifyParent;
  const LogedIn({Key? key, required this.notifyParent}) : super(key: key);

  @override
  State<LogedIn> createState() => _LogedInState();
}

class _LogedInState extends State<LogedIn> {
  logoutOnPressed(BuildContext context) {
    log("logout button pressed");

    try {
      Client.logout().then((resp) {
        if (resp?.status == "error") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(resp?.message ?? "Unknown Error"),
            ),
          );
        } else {
          widget.notifyParent();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Text("Logout Success"),
            ),
          );
        }
      });
    } catch (e) {
      log("Logout error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Logout failed, error: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Client.currentUser == null) {
      return Container();
    }
    ImageProvider avatar;
    var user = Client.currentUser!;
    String avatarUrl = user.avatar;
    if (avatarUrl.endsWith(".svg")) {
      avatar = Svg(avatarUrl, source: SvgSource.network);
    } else {
      avatar = NetworkImage(avatarUrl);
    }

    String json = jsonEncode(user);

    return Column(
      children: [
        CircleAvatar(
          backgroundImage: avatar,
          minRadius: 32,
          maxRadius: 64,
        ),
        const SizedBox(height: 20),
        Text("ID: ${user.id}"),
        const SizedBox(height: 20),
        Text("User Name: ${user.name}  \tEmail: ${user.email}"),
        const SizedBox(height: 20),
        SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: ColoredJson(
              data: json,
              indentLength: 2,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => logoutOnPressed(context),
          child: const Text("Logout"),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
