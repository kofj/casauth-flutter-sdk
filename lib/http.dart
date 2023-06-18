import 'dart:convert';

import 'package:casauth/vault.dart';
import 'package:http/http.dart' as http;
import 'package:casauth/errors.dart';
import 'package:casauth/casauth.dart';
import 'package:casauth/user.dart';
import 'package:flutter/material.dart';

class AuthResult {
  late int code;
  late String? status = "";
  late String? message = "";
  late Map<String, dynamic>? jsonBody;
  late List<dynamic>? listBody;

  AuthResult(int respCode,
      {String? respStatus, String? respMessage, Map<String, dynamic>? body}) {
    code = respCode;
    status = respStatus;
    message = respMessage;
    jsonBody = body;
  }
}

extension Http on CASAuth {
  Future<AuthResult> get(String endpoint,
      {Map<String, String>? extHeaders}) async {
    String url = CASAuth.server + endpoint;

    AuthResult resp = await request("get", url, null, extHeaders);

    if (resp.code == 200 && resp.message == "Access token doesn't exist") {
      await clearCache();
      debugPrint("token not exist, clear cache");
      throw CASAuthError(ErrorLevel.error, "Access token doesn't exist");
    }

    return resp;
  }

  Future<AuthResult> post(String endpoint,
      [String? body, Map<String, String>? extHeaders]) async {
    String url = CASAuth.server + endpoint;
    return request("post", url, body, extHeaders);
  }

  Future<AuthResult> request(String method, String uri,
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

    if (isLogin) {
      headers["Authorization"] = "Bearer $token";
    }

    method = method.toLowerCase();
    http.Response? response;
    if (method == 'get') {
      response = await http.get(url, headers: headers);
    } else if (method == 'post') {
      response = await http.post(url, headers: headers, body: body);
    } else {
      throw CASAuthError(ErrorLevel.error, 'Unsupported method: $method');
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
