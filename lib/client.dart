import 'dart:convert';

import 'package:casauth/utils.dart';
import 'package:http/http.dart' as http;

import 'package:casauth/casauth.dart';
import 'package:casauth/result.dart';
import 'package:casauth/user.dart';

class Client {
  static User? currentUser;
  static String? token;

// register a new user by username and password
  static Future<HttpResult> registerByUserName(
    String username,
    String password,
  ) async {
    var payload = jsonEncode({
      'username': username,
      'password': password,
      'appId': CASAuth.appId,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
    });

    HttpResult resp = await post('/api/signup', payload);

    return resp;
  }

  static Future<HttpResult> loginByUserName(
    String username,
    String password,
  ) async {
    var payload = jsonEncode({
      'username': username,
      'password': password,
      'appId': CASAuth.appId,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
      'autoSignin': true,
      'type': 'id_token',
    });

    HttpResult resp = await post('/api/login', payload);
    token = resp.jsonBody?['data'];
    currentUser = null;
    if (resp.code == 200 && token != null && token!.isNotEmpty) {
      await userInfo();
    }
    return resp;
  }

  static Future<CaptchaResult> getCaptcha() async {
    HttpResult resp = await get(
        '/api/get-captcha?applicationId=admin/app-built-in&isCurrentProvider=false');
    return CaptchaResult(resp);
  }

// sendCode sends a verification code to the user's phone or email
  static Future<HttpResult> sendCode(
    String dest, {
    AccountType? type = AccountType.phone,
    String? checkId = "",
    String? checkKey = "",
    String? checkType = "none",
    String? checkUser = "",
  }) async {
    if (type != AccountType.phone && type != AccountType.email) {
      return HttpResult(400,
          respStatus: "error", respMessage: "invalid account type: $type");
    }
    String body =
        "applicationId=admin/${CASAuth.app}&checkType=$checkType&checkId=$checkId&checkKey=$checkKey&dest=$dest&type=${type?.toShortString()}&checkUser=$checkUser";
    Map<String, String> extHeader = {
      "content-type": "application/x-www-form-urlencoded"
    };
    return await post("/api/send-verification-code", body, extHeader);
  }

  static Future<void> userInfo() async {
    HttpResult resp = await get('/api/get-account');
    Map<String, dynamic> json = resp.jsonBody?['data'] as Map<String, dynamic>;
    if (resp.code == 200 && json.isNotEmpty) {
      currentUser = User.fromJson(json);
    }
  }

  static Future<HttpResult> get(String endpoint,
      {Map<String, String>? extHeaders}) async {
    String url = CASAuth.server + endpoint;

    return request("get", url, null, extHeaders);
  }

  static Future<HttpResult> post(String endpoint,
      [String? body, Map<String, String>? extHeaders]) async {
    String url = CASAuth.server + endpoint;
    return request("post", url, body, extHeaders);
  }

  static Future<HttpResult> request(String method, String uri,
      [String? body, Map<String, String>? extHeaders]) async {
    var url = Uri.parse(uri);
    Map<String, String> headers = {
      "x-app-id": CASAuth.appId,
      "x-request-from": "casauth-sdk-flutter",
      "x-casauth-sdk-version": CASAuth.version,
    };
    if (extHeaders != null) {
      headers.addAll(extHeaders);
    }
    if (headers["content-type"] == null || headers["content-type"] == "") {
      headers["content-type"] = "application/json";
    }
    if (token != null) {
      headers["Authorization"] = "Bearer $token";
    }

    method = method.toLowerCase();
    http.Response? response;
    if (method == 'get') {
      response = await http.get(url, headers: headers);
    } else if (method == 'post') {
      response = await http.post(url, headers: headers, body: body);
    } else {
      throw Exception('Unsupported method: $method');
    }
    return parseResponse(response);
  }

  static HttpResult parseResponse(http.Response? resp) {
    HttpResult result = HttpResult(
      resp?.statusCode ?? 0,
    );
    if (resp == null) {
      return result;
    }
    var body = resp.body;
    var code = resp.statusCode;
    if (code != 200) {
      result.message = body;
      return result;
    }
    var data = jsonDecode(body);
    result.jsonBody = data;
    result.status = data['status'];
    result.message = data['msg'];

    return result;
  }
}
