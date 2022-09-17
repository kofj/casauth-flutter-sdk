library casauth;

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

import 'package:casauth/utils.dart';
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
    if (CASAuth.config.requiredSignupItem("Email") ||
        CASAuth.config.requiredSignupItem("Phone")) {
      throw ("Email and/or Phone is required, cannot signup with username only");
    }
    if (!CASAuth.config.hasSignupItem("Username")) {
      throw ("Username is exists, cannot signup with username");
    }
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
    String password, {
    bool autoSignin = false,
  }) async {
    var payload = jsonEncode({
      'username': username,
      'password': password,
      'appId': CASAuth.appId,
      'autoSignin': autoSignin,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
      'type': CASAuth.config.getGrantTokenType(),
    });

    HttpResult resp = await post('/api/login', payload);
    token = resp.jsonBody?['data'];
    currentUser = null;
    if (resp.code == 200 && token != null && token!.isNotEmpty) {
      await userInfo();
    }
    return resp;
  }

// will generate username and password if not provided and required
  static Future<HttpResult> registerByPhone(
    String phone,
    String code, {
    String? username,
    String? password,
    String countryCode = "86",
  }) async {
    if ((username == null || username.isEmpty) &&
        CASAuth.config.requiredSignupItem("Username")) {
      username = "${CASAuth.randomUsernamePrefix}${getRandomString(5)}";
    }

    if ((password == null || password.isEmpty) &&
        CASAuth.config.requiredSignupItem("Password")) {
      password = getRandomString(12);
    }

    if (countryCode.isEmpty) {
      countryCode = "86";
    }

    var payload = jsonEncode({
      'phone': phone,
      'phoneCode': code,
      'phonePrefix': countryCode,
      'username': username,
      'password': password,
      'appId': CASAuth.appId,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
    });
    HttpResult resp = await post('/api/signup', payload);

    return resp;
  }

  static Future<HttpResult> loginByCode(
    String phoneOrEmail,
    String code, {
    AccountType type = AccountType.phone,
    bool autoSignin = false,
    String countryCode = "86",
  }) async {
    switch (type) {
      case AccountType.phone:
        {
          if (!isCnPhoneNumber(phoneOrEmail)) {
            throw ("Phone number is not allowed");
          }
          break;
        }

      case AccountType.email:
        {
          if (!EmailValidator.validate(phoneOrEmail)) {
            throw ("Email is not valid");
          }
          break;
        }

      default:
        {
          // nothing
        }
    }

    var payload = jsonEncode({
      'code': code,
      'appId': CASAuth.appId,
      'username': phoneOrEmail,
      'autoSignin': autoSignin,
      'phonePrefix': countryCode,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
      'type': CASAuth.config.getGrantTokenType(),
    });

    HttpResult resp = await post('/api/login', payload);
    token = resp.jsonBody?['data'];
    currentUser = null;
    if (resp.code == 200 && token != null && token!.isNotEmpty) {
      await userInfo();
    }
    return resp;
  }

  static Future<HttpResult> registerByEmail(
    String email,
    String code, {
    String username = '',
    String password = '',
  }) async {
    if (username.isEmpty && CASAuth.config.requiredSignupItem("Username")) {
      username = "${CASAuth.randomUsernamePrefix}${getRandomString(5)}";
    }

    if (password.isEmpty && CASAuth.config.requiredSignupItem("Password")) {
      password = getRandomString(12);
    }

    var payload = jsonEncode({
      'email': email,
      'emailCode': code,
      'username': username,
      'password': password,
      'appId': CASAuth.appId,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
    });
    HttpResult resp = await post('/api/signup', payload);

    return resp;
  }

  static Future<CaptchaResult> getCaptcha() async {
    HttpResult resp = await get(
        '/api/get-captcha?applicationId=admin/app-built-in&isCurrentProvider=false');
    return CaptchaResult(resp);
  }

  static Future<HttpResult?> logout() async {
    HttpResult resp = await get('/api/login/oauth/logout?id_token_hint=$token');

    if (resp.code == 200 && resp.jsonBody?['data'] == "Affected") {
      token = null;
      currentUser = null;
      return resp;
    }

    return resp;
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
