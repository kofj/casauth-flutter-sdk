part of "casauth.dart";

class AuthResult {
  late int code;
  late String? status = "";
  late String? message = "";
  late Map<String, dynamic>? jsonBody;
  late List<dynamic>? listBody;
  late Cookie? cookie;

  AuthResult(int respCode,
      {String? respStatus, String? respMessage, Map<String, dynamic>? body}) {
    code = respCode;
    status = respStatus;
    message = respMessage;
    jsonBody = body;
  }
}

extension HttpReq on CASAuth {
  Future<AuthResult> get(String endpoint,
      {Map<String, String>? extHeaders, Cookie? cookie}) async {
    String url = server + endpoint;

    AuthResult resp = await request("get", url,
        body: null, extHeaders: extHeaders, cookie: cookie);

    if (resp.code == 200 && resp.message == "Access token doesn't exist") {
      await clearCache();
      debugPrint("token not exist, clear cache");
    }

    return resp;
  }

  Future<AuthResult> post(String endpoint,
      {String? body, Map<String, String>? extHeaders, Cookie? cookie}) async {
    String url = server + endpoint;
    return request("post", url,
        body: body, extHeaders: extHeaders, cookie: cookie);
  }

  Future<AuthResult> request(String method, String uri,
      {String? body, Map<String, String>? extHeaders, Cookie? cookie}) async {
    var url = Uri.parse(uri);
    Map<String, String> headers = {
      "x-app-id": appId,
      "x-request-from": "casauth-sdk-flutter",
      "x-casauth-sdk-version": version,
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

    if (cookie != null) {
      headers["Cookie"] = cookie.toCookieHeader;
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

    var setCookieHeader = resp.headers['set-cookie'];
    if (setCookieHeader != null && setCookieHeader != "") {
      result.cookie = Cookie.fromSetCookieHeader(setCookieHeader);
    }

    return result;
  }
}
