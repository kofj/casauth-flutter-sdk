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
    List<TableRow> rowList = [];
    rowList.addAll(
      [
        TableRow(children: [
          padding(const Text("CAS App")),
          padding(Text("${CASAuth.organization}/${CASAuth.app}")),
        ]),
        TableRow(children: [
          padding(const Text("Pkg Info")),
          padding(
            FutureBuilder(
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  PackageInfo package = snapshot.data as PackageInfo;
                  return Text(package.toString());
                }
                return const Text("loading...");
              }),
              future: PackageInfo.fromPlatform(),
            ),
          ),
        ]),
        if (!kReleaseMode)
          TableRow(children: [
            padding(const Text("CAS Server")),
            padding(Text(CASAuth.server)),
          ]),
        if (!kReleaseMode)
          TableRow(children: [
            padding(const Text("CAS AppID")),
            padding(Text(CASAuth.appId)),
          ]),
        TableRow(children: [
          padding(const Text("App Mode")),
          padding(const Text(
              "debug: $kDebugMode, release: $kReleaseMode, profile: $kProfileMode"))
        ]),
        TableRow(children: [
          padding(const Text("JWT Token")),
          padding(Text(CASAuth.token ?? "")),
        ]),
      ],
    );

    return padding(
      Table(
        columnWidths: const {
          0: FixedColumnWidth(100),
          1: FlexColumnWidth(),
        },
        border: TableBorder.all(
          color: Colors.black26,
          style: BorderStyle.solid,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          width: 2,
        ),
        children: rowList,
      ),
    );
  }
}
