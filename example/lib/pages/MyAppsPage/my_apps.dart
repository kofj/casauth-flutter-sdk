import 'package:casauth/casauth.dart';
import 'package:casauth/client.dart';
import 'package:casauth/result.dart';
import 'package:casauth_example/components/appcard.dart';
import 'package:flutter/material.dart';

class MyApps extends StatefulWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  Future<List<CasdoorApp>> fetchApps() async {
    var endpoint =
        "/api/get-organization-applications?owner=admin&organization=${CASAuth.organization}";
    AuthResult resp = await AuthClient.get(endpoint);

    if (resp.code == 200 && resp.listBody != null) {
      return resp.listBody!.map((e) => CasdoorApp.fromJson(e)).toList();
    }

    return [];
  }

  Widget _buildAppList(List<CasdoorApp> apps) {
    List<Widget> list = [];
    for (var app in apps) {
      var appCard = Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
        child: Column(children: [
          AppCard(app: app),
        ]),
      );
      list.add(appCard);
    }
    list.add(
      Column(
        children: const [
          TextButton(onPressed: null, child: Text("no more apps")),
          SizedBox(height: 20),
        ],
      ),
    );

    return Column(children: list);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CasdoorApp>>(
      future: fetchApps(),
      builder: (context, ss) {
        if (ss.connectionState == ConnectionState.done && ss.hasData) {
          return _buildAppList(ss.data!);
        } else if (ss.hasError) {
          return Center(child: Text("${ss.error}"));
        }
        return const Center(
          child: CircularProgressIndicator(
            semanticsLabel: "Loading...",
            semanticsValue: "Loading",
          ),
        );
      },
    );
  }
}
