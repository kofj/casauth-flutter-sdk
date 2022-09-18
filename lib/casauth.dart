library casauth;

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class CASAuth {
  static const String version = "1.1.0";

  static String app = "";
  static String appId = "";
  static String server = "";
  static String publicKey = "";
  static String organization = "";
  static Config config = configFromJson("{}");
  static String randomUsernamePrefix = "mobile_";

  CASAuth(String appName, String applicationId, String serverAddress,
      String orgName,
      {String? userPrefix}) {
    app = appName;
    appId = applicationId;
    server = serverAddress;
    organization = orgName;
    if (userPrefix != null) {
      randomUsernamePrefix = userPrefix;
    }
    init();
  }

  static Future<void> init() async {
    await requestApplicationConfig();
  }

  // retrieve application config from server
  static Future<void> requestApplicationConfig() async {
    var url = Uri.parse(
        "${CASAuth.server}/api/get-application?id=admin/${CASAuth.app}");
    Map<String, String> headers = {
      "x-app-id": CASAuth.appId,
      "x-request-from": "casauth-sdk-flutter",
      "x-casauth-sdk-version": CASAuth.version,
      "content-type": "application/json",
    };

    http.Response? resp = await http.get(url, headers: headers);
    if (resp.statusCode != 200) {
      throw Exception(
          "Failed to retrieve application config. resp code=${resp.statusCode}/body=${resp.body}");
    }
    config = configFromJson(resp.body);

    if (config.getGrantTokenType() == "") {
      throw Exception(
          "Application's OAuth grantTypes must has token and/or id_token");
    }
  }

  static Future<bool> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(keyToken, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyToken);
  }

  static Future<bool> rmToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(keyToken);
  }
}

String keyToken = "casauth_token";
