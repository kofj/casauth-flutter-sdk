import 'dart:convert';
import 'package:casauth/user.dart';
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

  String password = "hUQxzNTPw7IL"; // user password for all test cases

  await CASAuth.init();

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

  cleanVerificationRecordAddr() async {
    await db!.execute(
      "update verification_record set remote_addr=''",
    );
  }

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

      CaptchaResult resp = await AuthClient.getCaptcha();
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

      CaptchaResult resp = await AuthClient.getCaptcha();
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
      AuthResult resp =
          await AuthClient.sendCode("dest", type: AccountType.username);
      expect(resp.code, 400);
    });

    test("phone", () async {
      AuthResult resp =
          await AuthClient.sendCode("18888888888", type: AccountType.phone);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      await cleanVerificationRecordAddr();
    });

    test("email", () async {
      AuthResult resp =
          await AuthClient.sendCode("me@example.com", type: AccountType.email);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
    });

    test("email limit", () async {
      AuthResult resp =
          await AuthClient.sendCode("me@example.com", type: AccountType.email);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.status, "error",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.message, "you can only send one code in 60s",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      await cleanVerificationRecordAddr();
    });
  });

  group("register tests | ", () {
    String username = "user_${getRandomString(5)}";
    // echo '{"application":"testapp","organization":"dev","username":"user_dkTY8","password":"hUQxzNTPw7IL","agreement":true, "appId": "dc4b4df2fcfa9d2ef765"}' | http POST 'http://localhost:8000/api/signup'
    test("Register with username and password", () async {
      AuthResult resp = await AuthClient.registerByUserName(username, password);
      expect(resp.code, 200);
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.jsonBody?["data"], "$orgnazationName/$username");
    });

    test("Username exists", () async {
      AuthResult resp = await AuthClient.registerByUserName(username, password);
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNull);
      expect(resp.status, "error",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.message, "username already exists");
    });

    // echo '{"application":"testapp","organization":"dev","username":"user_dkTY8","password":"hUQxzNTPw7IL","autoSignin":true,"type":"id_token","phonePrefix":"86","samlRequest":""}' |http 'http://localhost:8000/api/login'

    test("Login with username and password", () async {
      AuthResult resp = await AuthClient.loginByUserName(username, password);
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNotNull);

      User? user = await CASAuth.getCurrentUser();
      expect(user, isNotNull);
      expect(user?.id, isNotEmpty);
      expect(user?.name, username);
      expect(user?.avatar, isNotEmpty);
      expect(user?.owner, orgnazationName);
      expect(user?.signupApplication, appName);
      expect(user?.score, 2000);
      expect(user?.ranking, greaterThan(1));

      expect(resp.status, "ok", reason: "raw resp: $resp");

      await AuthClient.logout();
    });

    test("Login with username and error password", () async {
      AuthResult resp =
          await AuthClient.loginByUserName(username, "error_password");
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNull);
      expect(resp.status, "error",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      expect(CASAuth.getCurrentUser(), throwsA(isA<AuthClientError>()));
    });

    test("Login with username that not exists", () async {
      AuthResult resp =
          await AuthClient.loginByUserName("user_not_exists", "hUQxzNTPw7IL");
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNull);
      expect(resp.status, "error",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      expect(CASAuth.getCurrentUser(), throwsA(isA<AuthClientError>()));
    });
  });

  group("register by phone | ", () {
    String phone = "188010${randomNumberString(5)}";
    String username = "user_${getRandomString(5)}";

    debugPrint("--== phone: $phone ==--\n");

    test("Register with phone and password", () async {
      AuthResult resp =
          await AuthClient.sendCode(phone, type: AccountType.phone);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      IResultSet query = await db!.execute(
        "select code from verification_record where receiver like '%$phone' order by created_time desc limit 1",
      );
      String code = query.rows.first.colByName("code")!;
      expect(query.affectedRows, BigInt.zero);
      expect(query.rows.length, 1);
      expect(code, isNotEmpty);

      AuthResult resp2 = await AuthClient.registerByPhone(phone, code,
          password: password, username: username);
      expect(resp2.code, 200);
      expect(resp2.status, "ok",
          reason: "resp: ${resp2.code}/${resp2.status}/${resp2.message}");
      expect(resp2.jsonBody?["data"], "$orgnazationName/$username");

      await cleanVerificationRecordAddr();
    });

    test("Login with phone and password", () async {
      AuthResult resp = await AuthClient.loginByUserName(phone, password);
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNotNull);
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      User? user = await CASAuth.getCurrentUser();
      debugPrint("--== logined ==--\n${jsonEncode(user)}\n\n");
      expect(user, isNotNull, reason: "currentUser: ${jsonEncode(user)}");
      expect(user?.phone, phone);
      expect(user?.id, isNotEmpty);
      expect(user?.avatar, isNotEmpty);
      expect(user?.owner, orgnazationName);
      expect(user?.signupApplication, appName);
      expect(user?.score, 2000);
      expect(user?.ranking, greaterThan(1));

      await cleanVerificationRecordAddr();
      await AuthClient.logout();
    });

    test("Login with phone code", () async {
      AuthResult codeResp =
          await AuthClient.sendCode(phone, type: AccountType.phone);
      expect(codeResp.code, 200,
          reason:
              "codeResp: ${codeResp.code}/${codeResp.status}/${codeResp.message}");
      IResultSet query = await db!.execute(
        "select code from verification_record where receiver like '%$phone' order by created_time desc limit 1",
      );
      String code = query.rows.first.colByName("code")!;
      expect(query.affectedRows, BigInt.zero);
      expect(query.rows.length, 1);
      expect(code, isNotEmpty);

      AuthResult resp = await AuthClient.loginByCode(phone, code);
      expect(resp.code, 200);
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      User? user = await CASAuth.getCurrentUser();
      expect(user, isNotNull, reason: "currentUser: ${jsonEncode(user)}");
      expect(resp.jsonBody?["data"], isNotNull);
      expect(user?.phone, phone);
      expect(user?.id, isNotEmpty);
      expect(user?.avatar, isNotEmpty);
      expect(user?.owner, orgnazationName);
      expect(user?.signupApplication, appName);
      expect(user?.score, 2000);
      expect(user?.ranking, greaterThan(1));

      // clean
      await cleanVerificationRecordAddr();
      await AuthClient.logout();
    });
  });

  group("regsiter by email", () {
    String username = "user_${getRandomString(5)}";
    String email = "$username@test.com";

    debugPrint("--== email: $email ==--\n");

    test("Register with email and password", () async {
      AuthResult codeResp =
          await AuthClient.sendCode(email, type: AccountType.email);
      expect(codeResp.code, 200,
          reason:
              "resp: ${codeResp.code}/${codeResp.status}/${codeResp.message}");
      IResultSet query = await db!.execute(
        "select code from verification_record where receiver like '%$email' order by created_time desc limit 1",
      );
      String code = query.rows.first.colByName("code")!;
      expect(query.affectedRows, BigInt.zero);
      expect(query.rows.length, 1);
      expect(code, isNotEmpty);

      AuthResult resp = await AuthClient.registerByEmail(email, code,
          password: password, username: username);
      expect(resp.code, 200);
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      expect(resp.jsonBody?["data"], "$orgnazationName/$username");

      await cleanVerificationRecordAddr();
    });

    test("Login with email and password", () async {
      AuthResult resp = await AuthClient.loginByUserName(email, password);
      expect(resp.code, 200);
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      User? user = await CASAuth.getCurrentUser();
      debugPrint("--== logined ==--\n${jsonEncode(user)}\n\n");
      expect(user, isNotNull, reason: "currentUser: ${jsonEncode(user)}");
      expect(resp.jsonBody?["data"], isNotNull);
      expect(user?.email, email);
      expect(user?.id, isNotEmpty);
      expect(user?.avatar, isNotEmpty);
      expect(user?.owner, orgnazationName);
      expect(user?.signupApplication, appName);
      expect(user?.score, 2000);
      expect(user?.ranking, greaterThan(1));

      await cleanVerificationRecordAddr();
      await AuthClient.logout();
    });

    test("Login with email and code", () async {
      AuthResult codeResp =
          await AuthClient.sendCode(email, type: AccountType.email);
      expect(codeResp.code, 200,
          reason:
              "codeResp: ${codeResp.code}/${codeResp.status}/${codeResp.message}");
      IResultSet query = await db!.execute(
        "select code from verification_record where receiver like '%$email' order by created_time desc limit 1",
      );
      String code = query.rows.first.colByName("code")!;
      expect(query.affectedRows, BigInt.zero);
      expect(query.rows.length, 1);
      expect(code, isNotEmpty);

      AuthResult resp =
          await AuthClient.loginByCode(email, code, type: AccountType.email);
      expect(resp.code, 200);
      expect(resp.status, "ok",
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");

      User? user = await CASAuth.getCurrentUser();
      expect(user, isNotNull, reason: "currentUser: ${jsonEncode(user)}");
      expect(resp.jsonBody?["data"], isNotNull);
      expect(user?.email, email);
      expect(user?.id, isNotEmpty);
      expect(user?.avatar, isNotEmpty);
      expect(user?.owner, orgnazationName);
      expect(user?.signupApplication, appName);
      expect(user?.score, 2000);
      expect(user?.ranking, greaterThan(1));

      // clean
      await cleanVerificationRecordAddr();
      await AuthClient.logout();
    });
  });
}
