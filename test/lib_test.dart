// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

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
      defaultValue: "http://localhost:8080");
  const String orgnazationName =
      String.fromEnvironment("CAS_ORG_NAME", defaultValue: "dev");

  CASAuth(appName, appId, server, orgnazationName);

  test("Check CASAuth Instance", () {
    expect(CASAuth.app, appName);
    expect(CASAuth.appId, appId);
    expect(CASAuth.server, server);
    expect(CASAuth.organization, orgnazationName);
  });

  group("register", () {
    Client();
    String username = "user_${getRandomString(5)}";
    String password = "hUQxzNTPw7IL";

    // echo '{"application":"testapp","organization":"dev","username":"user_dkTY8","password":"hUQxzNTPw7IL","agreement":true, "appId": "dc4b4df2fcfa9d2ef765"}' | http POST 'http://localhost:8000/api/signup'
    test("Register with username and password", () async {
      HttpResult resp = await Client.registerByUserName(username, password);
      expect(resp.code, 200);
      expect(resp.message, "ok");
      expect(resp.data["status"], "ok");
      expect(resp.data["data"], "$orgnazationName/$username");
    });

    test("Username exists", () async {
      HttpResult resp = await Client.registerByUserName(username, password);
      // print(jsonEncode(resp));
      expect(resp.code, 200);
      expect(resp.message, "ok");
      expect(resp.data["data"], null);
      expect(resp.data["status"], "error");
      expect(resp.data["msg"], "username already exists");
    });

    // echo '{"application":"testapp","organization":"dev","username":"user_dkTY8","password":"hUQxzNTPw7IL","autoSignin":true,"type":"id_token","phonePrefix":"86","samlRequest":""}' |http 'http://localhost:8000/api/login?clientId=dc4b4df2fcfa9d2ef765&scope=read,write'
  });
}
