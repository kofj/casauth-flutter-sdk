import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CasdoorApp {
  String logo = "";
  String appId = "";
  String appName = "";
  String displayName = "";
  String description = "";
  List<String> grantTypes = [""];

  CasdoorApp.fromJson(Map<String, dynamic> json) {
    List<String> grants = [];
    for (var l in json["grantTypes"]) {
      grants.add(l as String);
    }
    logo = json["logo"];
    grantTypes = grants;
    appName = json["name"];
    appId = json["clientId"];
    displayName = json["displayName"];
    description = json["description"];
  }
}

class AppCard extends StatelessWidget {
  final CasdoorApp app;
  const AppCard({Key? key, required this.app}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> grants = [];
    for (var grant in app.grantTypes) {
      grants.add(
        Container(
          padding: const EdgeInsets.all(3),
          child: ElevatedButton(
            onPressed: null,
            child: Text(
              grant,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 15.0,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(14.0),
        ),
      ), //设置圆角

      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(5, 15, 5, 10),
            height: 180,
            width: double.infinity,
            color: Colors.white70,
            child: CachedNetworkImage(
              imageUrl: app.logo,
              fit: BoxFit.contain,
            ),
          ),
          ListTile(
            title: Text("${app.appName} / ${app.displayName}"),
            subtitle:
                Text("AppId: ${app.appId}\nDescription: ${app.description}"),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: ListBody(
              children: [
                Wrap(
                  children: grants,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
