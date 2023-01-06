library casauth;

import 'dart:convert';
import 'dart:developer';

import 'package:casauth/client.dart';
import 'package:casauth/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class CASAuth {
  static SharedPreferences? _prefs;
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
  }

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
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
      log("init config failed: code=${resp.statusCode}/body=${resp.body}");
      throw Exception(
          "Failed to retrieve application config. resp code=${resp.statusCode}/body=${resp.body}");
    }
    config = configFromJson(resp.body);

    if (config.getGrantTokenType() == "") {
      throw Exception(
          "Application's OAuth grantTypes must has token and/or id_token");
    }
  }

  static bool get isLogin {
    log("isLogin: token=${token?.isNotEmpty}");
    return token != null;
  }

  static String? get token {
    return _prefs?.getString(keyToken);
  }

  static set token(String? token) {
    if (token != null) _prefs?.setString(keyToken, token);
  }

  // clear cache in local storage
  static Future<bool>? clearCache() {
    debugPrint("🕹 clearCache");
    return _prefs?.clear();
  }

  static _keyCurrentUser() {
    return "$organization.current.user}";
  }

  static set currentUser(User? user) {
    _prefs?.setString(_keyCurrentUser(), jsonEncode(user)).then((ok) {
      debugPrint("set currentUser $ok");
    });
  }

  static Future<User?> getCurrentUser() async {
    String? cache = _prefs?.getString(_keyCurrentUser());
    if (cache != null) {
      Map<String, dynamic> json = jsonDecode(cache);
      return User.fromJson(json);
    }

    return AuthClient.userInfo();
  }
}

String keyToken = "casauth_token";
