import 'dart:async';
import 'dart:io';
import 'dart:developer';
import 'dart:ui';
import 'package:casauth_demo/pages/SignUpPage/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:casauth_demo/components/envinfo.dart';
import 'package:casauth_demo/components/logedin.dart';
import 'package:casauth_demo/components/unlogin.dart';
import 'package:casauth_demo/config.dart';
import 'package:casauth/casauth.dart';
import 'package:casauth/client.dart';
import 'pages/LoginPage/log_in.dart';

Config config = Config();
Config devConfig = Config();
Config prodConfig = Config();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  String mode = const String.fromEnvironment("APP_MODE", defaultValue: "dev");
  appMode = mode.toAppMode();
  log("APP_MODE env: ${appMode.name}, mode: ${appMode.name}");

  rootBundle.loadString("dev.env").then((value) async {
    if (value.isNotEmpty) {
      devConfig = await loadConfigFromDotEnv("dev.env");
      config = devConfig;
    }
  }).catchError((e) {
    log("dev.env not found, use default config");
  });

  try {
    prodConfig = await loadConfigFromDotEnv("prod.env");
    if (appMode == AppMode.prod) {
      config = prodConfig;
    }
  } catch (e) {
    log("load prod.env error: ${e.toString()}");
    exit(1);
  }

  runZonedGuarded<Future<void>>(
    () async {
      FlutterError.onError = (FlutterErrorDetails details) {
        log("exception: ${details.exception}\n${details.stack}");
      };

      runApp(const MyApp());
    },
    ((error, stackTrace) {
      log("Error: $error\n\n${stackTrace.toString()}");
    }),
  );
}

Future<Config> loadConfigFromDotEnv(String file) async {
  var dot = DotEnv();
  await dot.load(fileName: file);
  var config = Config(
    appId: dot.env["CAS_APPID"].toString(),
    server: dot.env["CAS_SERVER"].toString(),
    appName: dot.env["CAS_APPNAME"].toString(),
    orgnazationName: dot.env["CAS_ORG_NAME"].toString(),
  );
  log("load config from $file, value: ${dot.env.toString()}, config: ${config.toString()}");
  return config;
}

void initSDK() {
  try {
    log("init casauth SDK: ${config.server}, ${config.appId}, ${config.appName}, ${config.orgnazationName}");
    CASAuth(
      config.appName,
      config.appId,
      config.server,
      config.orgnazationName,
    );
  } catch (e) {
    log("init casauth SDK failed: $e");
  }
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
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'CASAuth'),
        "/login": (context) => const LoginPage(),
        "/signup": (context) => const Signup(),
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
    initSDK();
  }

  void refresh() {
    setState(() {});
  }

  void showChangeCfgDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Change Config"),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    config = devConfig;
                    initSDK();
                    setState(() {
                      appMode = AppMode.dev;
                    });
                  },
                  child: const Text("dev")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    config = prodConfig;
                    initSDK();
                    setState(() {
                      appMode = AppMode.prod;
                    });
                  },
                  child: const Text("prod")),
            ],
          );
        });
  }

  Widget buildAppModeIcon() {
    if (appMode == AppMode.dev) {
      return const Icon(Icons.electrical_services);
    } else {
      return const Icon(Icons.new_releases);
    }
  }

  @override
  Widget build(BuildContext context) {
    log("current user: ${Client.currentUser}");

    var appbar = AppBar(
      leading: buildAppModeIcon(),
      title: InkWell(
        onDoubleTap: () => showChangeCfgDialog(context),
        child: Text(widget.title),
      ),
    );
    var list = <Widget>[SizedBox(height: appbar.preferredSize.height)];

    if (Client.currentUser == null) {
      list.add(Center(child: Unlogin(notifyParent: refresh)));
    } else {
      list.add(Center(child: LogedIn(notifyParent: refresh)));
    }
    // ignore: prefer_const_constructors
    list.add(EnvInfo());

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
