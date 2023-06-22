library casauth;

import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_sqlite/stash_sqlite.dart';
import 'package:http/http.dart' as http;
import 'package:xid/xid.dart';
import 'package:http_cookie_store/http_cookie_store.dart';
export 'package:http_cookie_store/http_cookie_store.dart' show Cookie;
export 'package:logger/logger.dart' show Level;

part './config.dart';
part './errors.dart';
part './vault.dart';
part './user.dart';
part './http.dart';
part './verification.dart';

late CASAuth casauth;

Future<void> init(
  appName,
  appID,
  serverAddress,
  organizationName, {
  Vault? vault,
  String? userPrefix,
  String? redirectUri,
  Level? logLevel = Level.info,
}) async {
  casauth = CASAuth(
    appName,
    appID,
    serverAddress,
    organizationName,
    defaultVault: vault,
    userPrefix: userPrefix,
    redirectUri: redirectUri,
    logLevel: logLevel,
  );
  await casauth.init();
}

class CASAuth {
  Vault? vault;
  String app = "";
  String appId = "";
  String server = "";
  String organization = "";
  String version = "2.0.0";
  Level? logLevel = Level.info;
  String redirectUri = "casauth";
  String randomUsernamePrefix = "mobile_";
  AppConfig? appConfig;

  late Logger logger;
  String? _token;
  User? _user;

  @override
  String toString() {
    return "app: $app, appId: $appId, server: $server, organization: $organization, version: $version, randomUsernamePrefix: $randomUsernamePrefix, appConfig: $appConfig";
  }

  CASAuth(
    appName,
    appID,
    serverAddress,
    organizationName, {
    Vault? defaultVault,
    String? userPrefix,
    String? redirectUri,
    Level? logLevel = Level.info,
  }) {
    app = appName;
    appId = appID;
    server = serverAddress;
    organization = organizationName;
    this.redirectUri = redirectUri ?? this.redirectUri;
    randomUsernamePrefix = userPrefix ?? randomUsernamePrefix;
    vault = defaultVault;
    logger = Logger(
      filter: null,
      printer: kDebugMode || kProfileMode
          ? PrettyPrinter(printTime: true)
          : PrefixPrinter(SimplePrinter(printTime: true)),
      output: null,
      level: logLevel,
    );
  }

  Future<void> init() async {
    // 1. fetch app config from server.
    appConfig = await fetchAppConfig();

    if (appConfig?.getGrantTokenType() == "") {
      throw CASAuthError(ErrorLevel.fatal,
          "Application's OAuth grantTypes must has token and/or id_token");
    }

    // 2. init vault store. used for store session, user info.
    if (vault == null) {
      final dbPath = "${Directory.current.path}/Data/casauth.db";
      final file = File(dbPath);

      final store = await newSqliteLocalVaultStore(file: file);
      vault = await store.vault(name: "casauth");
    }
    if (vault == null) {
      throw CASAuthError(ErrorLevel.fatal, "vault is null");
    }

    // 3. load user info from vault.
    _token = await vault?.get("token");
    var userJson = await vault?.get("user");
    if (userJson != null) {
      _user = User.fromJson(jsonDecode(userJson));
    }

    // 4. fetch user info from server.
    if (_token != null && _token!.isNotEmpty) {
      userInfo();
    }
  }
}
