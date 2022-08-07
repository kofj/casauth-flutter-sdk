library authing;

import 'config.dart';

class CASAuth {
  static const String version = "1.1.0";

  static String app = "";
  static String appId = "";
  static String server = "";
  static String publicKey = "";
  static String organization = "";
  static Config config = Config();

  CASAuth(String appName, String applicationId, String serverAddress,
      String orgName) {
    app = appName;
    appId = applicationId;
    server = serverAddress;
    organization = orgName;
  }

  static Future<void> init() async {
    await requestApplicationConfig();
  }

  // TODO: retrieve application config from server
  static Future<void> requestApplicationConfig() async {}
}
