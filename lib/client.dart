library casauth;

import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

import 'package:casauth/utils.dart';
import 'package:casauth/casauth.dart';
import 'package:casauth/result.dart';
import 'package:casauth/user.dart';

class AuthClient {
  // register a new user by username and password
  static Future<AuthResult> registerByUserName(
    String username,
    String password, {
    String displayName = "",
  }) async {
    if (CASAuth.config.requiredSignupEmail ||
        CASAuth.config.requiredSignupPhone) {
      throw ("Email and/or Phone is required, cannot signup with username only");
    }
    if (CASAuth.config.requiredSignupDisplayName && displayName.isEmpty) {
      displayName = username;
    }

    if (!CASAuth.config.hasSignupUsername) {
      throw ("Username is not exists, cannot signup with username");
    }
    var payload = jsonEncode({
      'username': username,
      'password': password,
      'displayName': displayName,
      'appId': CASAuth.appId,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
    });

    AuthResult resp = await post('/api/signup', payload);

    return resp;
  }

  static Future<AuthResult> loginByUserName(
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

    if (CASAuth.token != null) {
      log("token is not empty, logout before login");
      await logout();
    }

    AuthResult resp = await post('/api/login', payload);
    CASAuth.token = resp.jsonBody?['data'];
    if (resp.code == 200 && resp.status == "ok") {
      CASAuth.token = resp.jsonBody?['data'];
    }

    return resp;
  }

// will generate username and password if not provided and required
  static Future<AuthResult> registerByPhone(
    String phone,
    String code, {
    String username = '',
    String password = '',
    String displayName = '',
    String countryCode = "86",
  }) async {
    if ((username.isEmpty) && CASAuth.config.requiredSignupUsername) {
      username = "${CASAuth.randomUsernamePrefix}${getRandomString(5)}";
    }

    if (CASAuth.config.requiredSignupDisplayName && displayName.isEmpty) {
      displayName = username;
    }

    if ((password.isEmpty) && CASAuth.config.requiredSignupPassword) {
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
      'displayName': displayName,
      'appId': CASAuth.appId,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
    });
    AuthResult resp = await post('/api/signup', payload);

    return resp;
  }

  static Future<AuthResult> loginByCode(
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

    AuthResult resp = await post('/api/login', payload);
    if (resp.code == 200 && resp.status == "ok") {
      CASAuth.token = resp.jsonBody?['data'];
    }
    return resp;
  }

  static Future<AuthResult> registerByEmail(
    String email,
    String code, {
    String username = '',
    String password = '',
    String displayName = '',
  }) async {
    if (username.isEmpty && CASAuth.config.requiredSignupUsername) {
      username = "${CASAuth.randomUsernamePrefix}${getRandomString(5)}";
    }
    if (CASAuth.config.requiredSignupDisplayName && displayName.isEmpty) {
      displayName = username;
    }

    if (password.isEmpty && CASAuth.config.requiredSignupPassword) {
      password = getRandomString(12);
    }

    var payload = jsonEncode({
      'email': email,
      'emailCode': code,
      'username': username,
      'displayName': displayName,
      'password': password,
      'appId': CASAuth.appId,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
    });
    AuthResult resp = await post('/api/signup', payload);

    return resp;
  }

  static Future<CaptchaResult> getCaptcha() async {
    AuthResult resp = await get(
        '/api/get-captcha?applicationId=admin/app-built-in&isCurrentProvider=false');
    return CaptchaResult(resp);
  }

  static Future<AuthResult?> logout() async {
    AuthResult resp =
        await get('/api/login/oauth/logout?id_token_hint=${CASAuth.token}');

    log("logout resp: ${resp.code}, ${resp.jsonBody}");
    if (resp.code == 200 && resp.jsonBody?['data'] == "Affected") {
      CASAuth.clearCache();
      return resp;
    }

    return resp;
  }

// sendCode sends a verification code to the user's phone or email
  static Future<AuthResult> sendCode(
    String dest, {
    AccountType? type = AccountType.phone,
    String? checkId = "",
    String? checkKey = "",
    String? checkType = "none",
    String? checkUser = "",
  }) async {
    if (type != AccountType.phone && type != AccountType.email) {
      return AuthResult(400,
          respStatus: "error", respMessage: "invalid account type: $type");
    }
    String body =
        "applicationId=admin/${CASAuth.app}&checkType=$checkType&checkId=$checkId&checkKey=$checkKey&dest=$dest&type=${type?.toShortString()}&checkUser=$checkUser";
    Map<String, String> extHeader = {
      "content-type": "application/x-www-form-urlencoded"
    };
    return await post("/api/send-verification-code", body, extHeader);
  }

  static Future<User?> userInfo() async {
    AuthResult resp = await get('/api/get-account');
    if (resp.status == "error") {
      log("get user info failed: ${resp.message}");
      return null;
    }
    Map<String, dynamic> json = resp.jsonBody?['data'] as Map<String, dynamic>;
    if (resp.code == 200 && json.isNotEmpty) {
      return User.fromJson(json);
    }
    return null;
  }

  static Future<AuthResult> get(String endpoint,
      {Map<String, String>? extHeaders}) async {
    String url = CASAuth.server + endpoint;

    Future<AuthResult> resp = request("get", url, null, extHeaders);
    await resp.then((r) {
      if (r.code == 200 && r.message == "Access token doesn't exist") {
        CASAuth.clearCache();
      }
    });
    return resp;
  }

  static Future<AuthResult> post(String endpoint,
      [String? body, Map<String, String>? extHeaders]) async {
    String url = CASAuth.server + endpoint;
    return request("post", url, body, extHeaders);
  }

  static Future<AuthResult> request(String method, String uri,
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

    if (CASAuth.token != null && CASAuth.token!.isNotEmpty) {
      headers["Authorization"] = "Bearer ${CASAuth.token}";
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

  static AuthResult parseResponse(http.Response? resp) {
    AuthResult result = AuthResult(
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
    if (data is List<dynamic>) {
      result.listBody = data;
    } else {
      result.jsonBody = data;
      result.status = data['status'];
      result.message = data['msg'];
    }

    return result;
  }
}
