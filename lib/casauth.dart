library casauth;

import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:stash/stash_api.dart';
import 'package:stash_sqlite/stash_sqlite.dart';
import 'package:http/http.dart' as http;

part './config.dart';
part './errors.dart';
part './vault.dart';
part './user.dart';
part './http.dart';

late CASAuth casauth;

Future<void> init(
  appName,
  appID,
  serverAddress,
  organizationName, {
  Vault? vault,
  String? userPrefix,
  String? redirectUri,
}) async {
  casauth = CASAuth(
    appName,
    appID,
    serverAddress,
    organizationName,
    defaultVault: vault,
    userPrefix: userPrefix,
    redirectUri: redirectUri,
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
  String redirectUri = "casauth";
  String randomUsernamePrefix = "mobile_";
  AppConfig? appConfig;

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
  }) {
    app = appName;
    appId = appID;
    server = serverAddress;
    organization = organizationName;
    this.redirectUri = redirectUri ?? this.redirectUri;
    randomUsernamePrefix = userPrefix ?? randomUsernamePrefix;
    vault = defaultVault;
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
  }
}
