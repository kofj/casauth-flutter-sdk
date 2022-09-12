import 'package:casauth/casauth.dart';
import 'package:casauth_demo/config.dart';
import 'package:flutter/material.dart';

class EnvInfo extends StatefulWidget {
  const EnvInfo({Key? key}) : super(key: key);

  @override
  State<EnvInfo> createState() => _EnvInfoState();
}

class _EnvInfoState extends State<EnvInfo> {
  Widget padding(Widget child) {
    return Padding(padding: const EdgeInsets.all(6), child: child);
  }

  @override
  Widget build(BuildContext context) {
    var rowList = <TableRow>[];
    if (appIsDebug) {
      rowList.addAll(
        [
          TableRow(children: [
            padding(const Text("App Mode")),
            padding(Text(appMode.name)),
          ]),
          TableRow(children: [
            padding(const Text("CAS Server")),
            padding(Text(CASAuth.server)),
          ]),
          TableRow(children: [
            padding(const Text("CAS App ID")),
            padding(Text(CASAuth.appId)),
          ]),
          TableRow(children: [
            padding(const Text("CAS App Name")),
            padding(Text(CASAuth.app)),
          ]),
          TableRow(children: [
            padding(const Text("CAS Org Name")),
            padding(Text(CASAuth.organization)),
          ]),
        ],
      );
    } else {
      rowList.addAll([
        TableRow(children: [
          padding(const Text("App Mode")),
          padding(Text(appMode.name)),
        ]),
        TableRow(children: [
          padding(const Text("CAS App Name")),
          padding(Text(CASAuth.app)),
        ]),
      ]);
    }

    return padding(Column(
      children: [
        const SizedBox(height: 120),
        Table(
          border: TableBorder.all(
            color: Colors.black26,
            style: BorderStyle.solid,
            width: 2,
          ),
          children: rowList,
        ),
      ],
    ));
  }
}
