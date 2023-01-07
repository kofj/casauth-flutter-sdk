import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static Future<Config> loadDotEnv(String name) async {
    var file = "$name.env";
    var dot = DotEnv();
    try {
      await dot.load(fileName: file);
    } catch (err) {
      throw Exception("load $file error: ${err.runtimeType}");
    }

    var config = Config(
      appId: dot.env["CAS_APPID"].toString(),
      server: dot.env["CAS_SERVER"].toString(),
      appName: dot.env["CAS_APPNAME"].toString(),
      orgnazationName: dot.env["CAS_ORG_NAME"].toString(),
    );
    debugPrint(
        "load config from $file, value: ${dot.env.toString()}, config: ${config.toString()}");
    return config;
  }
}
