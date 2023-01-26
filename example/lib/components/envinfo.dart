import 'dart:io';

import 'package:casauth/casauth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class EnvInfo extends StatefulWidget {
  const EnvInfo({Key? key}) : super(key: key);

  @override
  State<EnvInfo> createState() => _EnvInfoState();
}

class _EnvInfoState extends State<EnvInfo> {
  Widget padding(Widget child) {
    return Padding(padding: const EdgeInsets.all(8), child: child);
  }

  @override
  Widget build(BuildContext context) {
    Map<String, Widget> kvs = {
      "CAS App": Text("${CASAuth.organization}/${CASAuth.app}"),
      "SDK Version": Text(Platform.version),
      "Pkg Info": FutureBuilder(
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            PackageInfo package = snapshot.data as PackageInfo;
            return Text(package.toString());
          }
          return const Text("loading...");
        }),
        future: PackageInfo.fromPlatform(),
      ),
      if (!kReleaseMode) "Token Key": Text(CASAuth.keyToken),
      if (!kReleaseMode) "CAS AppID": Text(CASAuth.appId),
      "App Mode": const Text(
          "debug: $kDebugMode, release: $kReleaseMode, profile: $kProfileMode"),
      "JWT Token": Text(CASAuth.token ?? ""),
    };

    var childs = kvs.entries.map((item) {
      return Card(
        elevation: 5.0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5.0),
          ),
        ),
        child: ListTile(
          title: Text(item.key),
          subtitle: item.value,
        ),
      );
    }).toList();

    //
    return Column(children: childs);
  }
}
