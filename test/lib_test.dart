import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysql_client/mysql_client.dart';

import 'package:casauth/casauth.dart';
import 'package:casauth/client.dart';
import 'package:casauth/utils.dart';
import 'package:casauth/result.dart';

void main() async {
  const String appName =
      String.fromEnvironment("CAS_APPNAME", defaultValue: "testapp");
  const String appId =
      String.fromEnvironment("CAS_APPID", defaultValue: "dc4b4df2fcfa9d2ef765");
  const String server = String.fromEnvironment("CAS_SERVER",
      defaultValue: "http://localhost:8000");
  const String orgnazationName =
      String.fromEnvironment("CAS_ORG_NAME", defaultValue: "dev");

  debugPrint(
      "---=== TEST ===---\nCAS_SERVER: $server\nCAS_APPNAME: $appName\nCAS_APPID: $appId\n---=== TEST ===---\n");
  CASAuth(appName, appId, server, orgnazationName);

  test('test config', () async {
    var cfg = CASAuth.config;
    expect(cfg.name, appName);
    expect(cfg.owner, "admin");
    expect(cfg.clientId, appId);
    expect(cfg.organization, orgnazationName);
  });

  test("Check CASAuth Instance", () {
    expect(CASAuth.app, appName);
    expect(CASAuth.appId, appId);
    expect(CASAuth.server, server);
    expect(CASAuth.organization, orgnazationName);
  });

  const int dbPort = 3306;
  const String dbHost = "127.0.0.1";
  const String dbUser = "root";
  const String dbName = "casdoor";
  const String dbPassword = "JKGgWFf9XTW+FRhamg+T2Xht8e9S12MK";
  // debugPrint("mysql://$dbUser:$dbPassword@$dbHost:$dbPort/$dbName\n");

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
  });

  tearDown(() async {
    await db!.close();
  });

  test('ping database', () async {
    expect(db!.connected, isTrue);
    IResultSet ping = await db!.execute("SELECT 1 as value");
    expect(ping.affectedRows, BigInt.zero);
    expect(ping.numOfRows, 1);
    expect(ping.rows.length, 1);
    expect(ping.rows.first.colByName("value"), "1");
  });

  group("tests captcha | ", () {
    test("default type", () async {
      IResultSet rs = await db!.execute(
        "update provider set type=:type where name=:name",
        {
          "type": "Default",
          "name": "provider_captcha_default",
        },
      );

      expect(rs.affectedRows.toInt(), greaterThan(-1));

      CaptchaResult resp = await Client.getCaptcha();
      expect(resp.code, 200);
      expect(resp.status, "ok");
      expect(resp.message, isEmpty);
      expect(resp.captcha, isNotNull);
      expect(resp.captcha?.type, "Default");
      expect(resp.captcha?.captchaId, isNotEmpty);
      expect(resp.captcha?.captchaImage, isNotEmpty);
      // is png image
      expect(
        resp.captcha?.captchaImage?.contains("iVBORw0KGgoAAAANSUhEUgAAAMgAAA"),
        isTrue,
      );
    });

    test("none captcha", () async {
      IResultSet rs = await db!.execute(
        "update provider set type=:type where name=:name",
        {
          "type": "",
          "name": "provider_captcha_default",
        },
      );

      expect(rs.affectedRows, BigInt.one);

      CaptchaResult resp = await Client.getCaptcha();
      expect(resp.code, 200);
      expect(resp.status, "ok");
      expect(resp.message, isEmpty);
      expect(resp.captcha, isNotNull);
      expect(resp.captcha?.type, "none");
      expect(resp.captcha?.captchaId, isEmpty);
      expect(resp.captcha?.captchaImage, isNull);
    });
  });

  group("send verfiy code | ", () {
    test("invalid account type", () async {
      HttpResult resp =
          await Client.sendCode("dest", type: AccountType.username);
      expect(resp.code, 400);
    });

    // test("phone", () async {
    //   HttpResult resp =
    //       await Client.sendCode("18888888888", type: AccountType.phone);
    //   expect(resp.code, 200,
    //       reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
    //   // expect(resp.status, "ok",
    //   //     reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
    // });

    test("email", () async {
      HttpResult resp =
          await Client.sendCode("me@example.com", type: AccountType.email);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
    });

    test("email limit", () async {
      HttpResult resp =
          await Client.sendCode("me@example.com", type: AccountType.email);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.status, "error",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.message, "You can only send one code in 60s.",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
    });
  });

  group("register tests | ", () {
    String username = "user_${getRandomString(5)}";
    String password = "hUQxzNTPw7IL";
    // echo '{"application":"testapp","organization":"dev","username":"user_dkTY8","password":"hUQxzNTPw7IL","agreement":true, "appId": "dc4b4df2fcfa9d2ef765"}' | http POST 'http://localhost:8000/api/signup'
    test("Register with username and password", () async {
      HttpResult resp = await Client.registerByUserName(username, password);
      expect(resp.code, 200);
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.jsonBody?["data"], "$orgnazationName/$username");
    });

    test("Username exists", () async {
      HttpResult resp = await Client.registerByUserName(username, password);
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNull);
      expect(resp.status, "error",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.message, "username already exists");
    });

    // echo '{"application":"testapp","organization":"dev","username":"user_dkTY8","password":"hUQxzNTPw7IL","autoSignin":true,"type":"id_token","phonePrefix":"86","samlRequest":""}' |http 'http://localhost:8000/api/login'

    test("Login with username and password", () async {
      HttpResult resp = await Client.loginByUserName(username, password);
      expect(resp.code, 200);
      expect(Client.currentUser, isNotNull);
      expect(resp.jsonBody?["data"], isNotNull);
      expect(Client.currentUser?.id, isNotEmpty);
      expect(Client.currentUser?.name, username);
      expect(Client.currentUser?.avatar, isNotEmpty);
      expect(Client.currentUser?.owner, orgnazationName);
      expect(Client.currentUser?.signupApplication, appName);
      expect(Client.currentUser?.score, 2000);
      expect(Client.currentUser?.ranking, greaterThan(1));

      expect(resp.status, "ok", reason: "raw resp: $resp");
    });

    test("Login with username and error password", () async {
      HttpResult resp =
          await Client.loginByUserName(username, "error_password");
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNull);
      expect(resp.status, "error",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      expect(Client.currentUser, null,
          reason: "currentUser: ${jsonEncode(Client.currentUser)}");
    });

    test("Login with username that not exists", () async {
      HttpResult resp =
          await Client.loginByUserName("user_not_exists", "hUQxzNTPw7IL");
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNull);
      expect(resp.status, "error",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      expect(Client.currentUser, null,
          reason: "currentUser: ${jsonEncode(Client.currentUser)}");
    });
  });

  group("register by phone | ", () {
    String phone = "18888888880";
    String password = "hUQxzNTPw7IL";
    String username = "user_${getRandomString(5)}";

    test("Register with phone and password", () async {
      HttpResult resp = await Client.sendCode(phone, type: AccountType.phone);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      // expect(resp.status, "ok",
      //     reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      IResultSet query = await db!.execute(
        "select code from verification_record where receiver like '%$phone' order by created_time desc limit 1",
      );
      String code = query.rows.first.colByName("code")!;
      expect(query.affectedRows, BigInt.zero);
      expect(query.rows.length, 1);
      expect(code, isNotEmpty);

      HttpResult resp2 = await Client.registerByPhone(phone, code,
          password: password, username: username);
      expect(resp2.code, 200);
      expect(resp2.status, "ok",
          reason: "resp: ${resp2.code}/${resp2.status}/${resp2.message}");
      expect(resp2.jsonBody?["data"], "$orgnazationName/$username");
    });
  });
}
