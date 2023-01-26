import 'dart:ui';
import 'dart:async';
import 'dart:developer';
import 'package:casauth_example/pages/EnvInfoPage/env_info_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:casauth_example/pages/SignUpPage/sign_up.dart';
import 'package:casauth_example/components/logedin.dart';
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
        "/login": (context) => LoginPage(notifyParent: () => null),
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
  int _currentIndex = 0;

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

    Widget body = Container();
    Widget? navbar;

    if (CASAuth.isLogin) {
      switch (_currentIndex) {
        case 0:
          body = const MyApps();
          break;
        case 1:
          body = const EnvInfoPage();
          break;

        case 2:
          body = LogedIn(notifyParent: refresh);
          break;

        default:
          body = LogedIn(notifyParent: refresh);
          break;
      }

      // body = const BottomNavigationBarPage();
      navbar = BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.energy_savings_leaf),
            label: "Env",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apps),
            label: "Mine",
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      );
    } else {
      body = SafeArea(
        child: LoginPage(notifyParent: () {
          setState(() {
            _currentIndex = 0;
          });
        }),
      );
    }

    return Scaffold(
      appBar: appbar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: body,
      ),
      bottomNavigationBar: navbar,
    );
  }
}
