// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:casauth/casauth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql_client/mysql_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const String appName =
      String.fromEnvironment("CAS_APPNAME", defaultValue: "testapp");
  const String appId =
      String.fromEnvironment("CAS_APPID", defaultValue: "45bcc334a4ca4b0b6eaf");
  const String server = String.fromEnvironment("CAS_SERVER",
      defaultValue: "http://localhost:8000");
  const String orgnazationName =
      String.fromEnvironment("CAS_ORG_NAME", defaultValue: "dev");

  const int dbPort = int.fromEnvironment("UT_MYSQL_PORT", defaultValue: 3306);
  const String dbHost =
      String.fromEnvironment("UT_MYSQL_HOST", defaultValue: "mysql.");
  const String dbUser = "root";
  const String dbName = "casdoor";
  const String dbPassword = "JKGgWFf9XTW+FRhamg+T2Xht8e9S12MK";
  MySQLConnection? db;

  setUp(() async {
    db = await MySQLConnection.createConnection(
      host: dbHost,
      port: dbPort,
      userName: dbUser,
      password: dbPassword,
      databaseName: dbName,
    );
    if (db!.connected) {
      return;
    }
    await db!.connect(timeoutMs: 1000);

    debugPrint("---=== start setup ===---\n");

    debugPrint("---=== setup done ===---\n");
  });

  tearDown(() async {
    await db?.execute("update verification_record set remote_addr=''").then(
          (r) => debugPrint(
            "clean verify record add affected rows: ${r.affectedRows}",
          ),
        );

    await db?.close();

    debugPrint("----------- tear down -----------\n\n");
  });

  test("config fatal failed", () {
    expect(
      CASAuth("appName", appId, server, orgnazationName).init(),
      throwsA(
        predicate(
          (x) => x is CASAuthError && x.level == ErrorLevel.fatal,
        ),
      ),
    );
  });

  test('test config success', () async {
    await init(appName, appId, server, orgnazationName);

    var cfg = casauth.appConfig;
    debugPrint("🔥 appConfig: $cfg");

    expect(cfg?.name, appName);
    expect(cfg?.owner, "admin");
    expect(cfg?.clientId, appId);
    expect(cfg?.organization, orgnazationName);
  });
}
