import 'dart:ui';
import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:casauth_example/pages/SignUpPage/sign_up.dart';
import 'package:casauth_example/components/envinfo.dart';
import 'package:casauth_example/components/logedin.dart';
import 'package:casauth_example/components/unlogin.dart';
import 'package:casauth_example/config.dart';
import 'package:casauth/casauth.dart';
import 'pages/LoginPage/log_in.dart';
import 'pages/MyAppsPage/my_apps.dart';

String currentEnv = const String.fromEnvironment("ENV", defaultValue: "prod");

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  var config = await Config.loadDotEnv(currentEnv);

  await initCASAuth(config);

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

Future<void> initCASAuth(Config config) async {
  try {
    log("init casauth SDK: ${config.server}, ${config.appId}, ${config.appName}, ${config.orgnazationName}");
    CASAuth(
      config.appName,
      config.appId,
      config.server,
      config.orgnazationName,
    );
    await CASAuth.init();
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
        "/myapps": (context) => const MyApps(),
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
  void showChangeCfgDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          var envs = ["local", "dev", "prod"];
          List<Widget> btns = [];
          btns.addAll(
            envs.map((env) {
              return ElevatedButton(
                  onPressed: () {
                    Config.loadDotEnv(env).then(
                      (cfg) {
                        initCASAuth(cfg);
                        currentEnv = env;
                        setState(() {});
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content:
                                Text("Config changed to [$env] env success"),
                          ),
                        );
                      },
                    ).onError((error, stackTrace) {
                      debugPrint("load config failed: $error");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text(
                              "Config changed to $env failed, error: $error"),
                        ),
                      );
                    });

                    Navigator.pop(context);
                  },
                  child: Text(env));
            }),
          );

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Change Config"),
            actions: btns,
          );
        });
  }

  Widget buildAppModeIcon() {
    var icon = Icons.new_releases;
    if (kDebugMode) {
      icon = Icons.electrical_services;
    } else if (kProfileMode) {
      icon = Icons.precision_manufacturing_outlined;
    } else {
      icon = Icons.new_releases;
    }

    return Container(
      padding: const EdgeInsets.all(3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          Text("env: $currentEnv", style: const TextStyle(fontSize: 11))
        ],
      ),
    );
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
      leading: buildAppModeIcon(),
      title: InkWell(
        onDoubleTap: () => showChangeCfgDialog(context),
        child: Text(widget.title),
      ),
    );
    var list = <Widget>[SizedBox(height: appbar.preferredSize.height)];

    log("token length: ${CASAuth.token?.length}");
    if (CASAuth.isLogin) {
      list.add(Center(child: LogedIn(notifyParent: refresh)));
    } else {
      list.add(Center(child: Unlogin(notifyParent: refresh)));
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
