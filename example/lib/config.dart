import 'package:flutter/foundation.dart';

AppMode appMode = AppMode.dev;

bool get appIsDebug => appMode == AppMode.dev;

enum AppMode {
  dev,
  prod,
}

extension AppModeEx on String {
  AppMode toAppMode() => AppMode.values.firstWhere(
        (d) => describeEnum(d) == toLowerCase(),
      );
}

class Config {
  String appName = "none";
  String appId = "none";
  String orgnazationName = "none";
  String server = "none";

  Config({
    this.appName = "testapp",
    this.appId = "dc4b4df2fcfa9d2ef765",
    this.orgnazationName = "dev",
    this.server = "http://localhost:8000",
  });

  @override
  String toString() {
    return "Config(appName: $appName, appId: $appId, orgnazationName: $orgnazationName, server: $server)";
  }
}
