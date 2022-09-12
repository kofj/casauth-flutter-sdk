import 'dart:developer';
import 'package:casauth_demo/components/envinfo.dart';
import 'package:casauth_demo/components/logedin.dart';
import 'package:casauth_demo/components/unlogin.dart';
import 'package:flutter/material.dart';
import 'package:casauth/casauth.dart';
import 'package:casauth/client.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/LoginPage/log_in.dart';

String appName = "testapp";
String appId = "dc4b4df2fcfa9d2ef765";
String server = "http://localhost:8000";
String orgnazationName = "dev";
String appMode = "dev";

void main() async {
  await dotenv.load();
  appId = dotenv.env['CAS_APPID'] ?? appId;
  appMode = dotenv.env['APP_MODE'] ?? appMode;
  server = dotenv.env['CAS_SERVER'] ?? server;
  appName = dotenv.env['CAS_APPNAME'] ?? appName;
  orgnazationName = dotenv.env['CAS_ORG_NAME'] ?? orgnazationName;

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CASAuth Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'CASAuth Demo Home Page'),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'CASAuth'),
        "/login": (context) => const LoginPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    try {
      log("init casauth SDK: $server, $appId, $appName, $orgnazationName");
      CASAuth(appName, appId, server, orgnazationName);
    } catch (e) {
      log("init casauth SDK failed: $e");
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    log("current user: ${Client.currentUser}");

    var appbar = AppBar(title: Text(widget.title));
    var list = <Widget>[SizedBox(height: appbar.preferredSize.height)];

    if (Client.currentUser == null) {
      list.add(Unlogin(notifyParent: refresh));
    } else {
      list.add(LogedIn(notifyParent: refresh));
    }
    list.add(EnvInfo(appMode: appMode));

    return Scaffold(
      appBar: appbar,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: list,
          ),
        ),
      ),
    );
  }
}
