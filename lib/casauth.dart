library casauth;

import 'dart:io';

import 'package:stash/stash_api.dart';
import 'package:stash_sqlite/stash_sqlite.dart';

import 'config.dart';
import 'errors.dart';

class CASAuth {
  static Vault? defaultVault;
  static String app = "";
  static String appId = "";
  static String server = "";
  static String organization = "";
  static String version = "2.0.0";
  static String randomUsernamePrefix = "mobile_";
  static AppConfig appConfig = configFromJson("{}");

  @override
  String toString() {
    return "app: $app, appId: $appId, server: $server, organization: $organization, version: $version, randomUsernamePrefix: $randomUsernamePrefix, appConfig: $appConfig";
  }

  CASAuth(
    appName,
    appID,
    serverAddress,
    organizationName, {
    Vault? vault,
    String? userPrefix,
  }) {
    app = appName;
    appId = appID;
    server = serverAddress;
    organization = organizationName;

    Future.delayed(Duration.zero, () async {
      // 1. init vault store. used for store session, user info.
      if (vault == null) {
        final dbPath = "${Directory.current.path}/Data/casauth.db";
        final file = File(dbPath);

        final store = await newSqliteLocalVaultStore(file: file);
        vault = await store.vault(name: "casauth");
      }

      if (vault == null) {
        throw CASAuthError(ErrorLevel.fatal, "vault is null");
      }

      defaultVault = vault;

      if (userPrefix != null) {
        randomUsernamePrefix = userPrefix;
      }

      // 2. fetch app config from server.
      appConfig = await fetchAppConfig();

      if (appConfig.getGrantTokenType() == "") {
        throw CASAuthError(ErrorLevel.fatal,
            "Application's OAuth grantTypes must has token and/or id_token");
      }
    });
  }
}
