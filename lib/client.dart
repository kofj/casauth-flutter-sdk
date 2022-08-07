import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:casauth/casauth.dart';
import 'package:casauth/result.dart';
import 'package:casauth/user.dart';

class Client {
  static User? currentUser;

// register a new user by username and password
  static Future<HttpResult> registerByUserName(
    String email,
    String password,
  ) async {
    var payload = jsonEncode({
      'username': email,
      'password': password,
      'appId': CASAuth.appId,
      'application': CASAuth.app,
      'organization': CASAuth.organization,
    });

    HttpResult resp = await post('/api/signup', payload);

    return resp;
  }

  static Future<HttpResult> get(String endpoint) async {
    String url = CASAuth.server + endpoint;

    return request("get", url, null);
  }

  static Future<HttpResult> post(String endpoint, [String? body]) async {
    String url = CASAuth.server + endpoint;
    return request("post", url, body);
  }

  static Future<HttpResult> request(String method, String uri,
      [String? body]) async {
    var url = Uri.parse(uri);
    Map<String, String> headers = {
      "x-app-id": CASAuth.appId,
      "x-request-from": "casauth-sdk-flutter",
      "x-casauth-sdk-version": CASAuth.version,
      "content-type": "application/json"
    };

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

  static HttpResult parseResponse(http.Response? response) {
    HttpResult result = HttpResult("error");
    if (response == null) {
      return result;
    }
    var body = response.body;
    var code = response.statusCode;
    if (code != 200) {
      return HttpResult(
        body,
        codev: code,
      );
    }
    var data = jsonDecode(body);
    return HttpResult(
      "ok",
      codev: code,
      datamap: data,
    );
  }
}
