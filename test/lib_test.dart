import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:casauth/casauth.dart';
import 'package:casauth/client.dart';
import 'package:casauth/utils.dart';
import 'package:casauth/result.dart';

void main() {
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

  test("Check CASAuth Instance", () {
    expect(CASAuth.app, appName);
    expect(CASAuth.appId, appId);
    expect(CASAuth.server, server);
    expect(CASAuth.organization, orgnazationName);
  });

  group("send verfiy code | ", () {
    test("invalid account type", () async {
      HttpResult resp =
          await Client.sendCode("dest", type: AccountType.username);
      expect(resp.code, 400);
    });

    test("phone", () async {
      HttpResult resp =
          await Client.sendCode("18888888888", type: AccountType.phone);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      // expect(resp.status, "ok",
      //     reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
    });

    test("email", () async {
      HttpResult resp =
          await Client.sendCode("me@example.com", type: AccountType.email);
      expect(resp.code, 200,
          reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
      // expect(resp.status, "ok",
      //     reason: "resp: ${resp.code}/${resp.status}/${resp.message}");
    });
  });

  group("register tests | ", () {
    String username = "user_${getRandomString(5)}";
    String password = "hUQxzNTPw7IL";
    // echo '{"application":"testapp","organization":"dev","username":"user_dkTY8","password":"hUQxzNTPw7IL","agreement":true, "appId": "dc4b4df2fcfa9d2ef765"}' | http POST 'http://localhost:8000/api/signup'
    test("Register with username and password", () async {
      HttpResult resp = await Client.registerByUserName(username, password);
      expect(resp.code, 200);
      expect(resp.status, "ok", reason: "raw resp: $resp");
      expect(resp.jsonBody?["data"], "$orgnazationName/$username");
    });

    test("Username exists", () async {
      HttpResult resp = await Client.registerByUserName(username, password);
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNull);
      expect(resp.message, "username already exists");
      expect(resp.status, "error", reason: "raw resp: $resp");
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
      expect(resp.status, "error", reason: "raw resp: $resp");

      expect(Client.currentUser, null,
          reason: "currentUser: ${jsonEncode(Client.currentUser)}");
    });

    test("Login with username that not exists", () async {
      HttpResult resp =
          await Client.loginByUserName("user_not_exists", "hUQxzNTPw7IL");
      expect(resp.code, 200);
      expect(resp.jsonBody?["data"], isNull);
      expect(resp.status, "error", reason: "raw resp: $resp");

      expect(Client.currentUser, null,
          reason: "currentUser: ${jsonEncode(Client.currentUser)}");
    });
  });
}
