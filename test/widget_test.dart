// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql_client/mysql_client.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  const int dbPort = 3306;
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
}
