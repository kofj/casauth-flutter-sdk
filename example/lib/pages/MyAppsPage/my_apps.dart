import 'package:casauth/casauth.dart';
import 'package:casauth/client.dart';
import 'package:casauth/result.dart';
import 'package:casauth_demo/components/appcard.dart';
import 'package:flutter/material.dart';

class MyApps extends StatefulWidget {
  const MyApps({Key? key}) : super(key: key);

  @override
  State<MyApps> createState() => _MyAppsState();
}

class _MyAppsState extends State<MyApps> {
  List<CasdoorApp> apps = [];

  @override
  void initState() {
    super.initState();

    fetchApps();
  }

  fetchApps() async {
    var endpoint =
        "/api/get-organization-applications?owner=admin&organization=${CASAuth.organization}";
    AuthResult resp = await AuthClient.get(endpoint);

    if (resp.code == 200 && resp.listBody != null) {
      apps.addAll(resp.listBody!.map((e) => CasdoorApp.fromJson(e)).toList());
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Apps"),
      ),
      body: SingleChildScrollView(
        child: Column(children: list),
      ),
    );
  }
}
