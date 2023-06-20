part of casauth;

extension Verification on CASAuth {
  Future<AuthResult> sendCode(
    String dest, {
    String? checkUser = "",
    String? method = "signup",
    String? countryCode = "86",
    String? captchaType = "none",
    AccountType? type = AccountType.phone,
  }) async {
    if (type != AccountType.phone && type != AccountType.email) {
      throw CASAuthError(ErrorLevel.error, "invalid account type");
    }

    if (isLogin) {
      log("token is not empty, logout before login");
      await logout();
    }

    String body =
        "applicationId=admin/$app&method=$method&captchaType=$captchaType&dest=$dest&type=${type?.toShortString()}&checkUser=$checkUser";
    Map<String, String> extHeaders = {
      "content-type": "application/x-www-form-urlencoded"
    };
    debugPrint("🔥 sendCode body: $body");

    var resp = await post("/api/send-verification-code",
        body: body, extHeaders: extHeaders);
    if (resp.code != 200) {
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${resp.code}");
    }
    if (resp.status == "error") {
      throw CASAuthError(
          ErrorLevel.error, resp.message ?? "none sendCode error message");
    }
    return resp;
  }

  Future<(bool, String?)> verifyCode(String account, String code) async {
    String body = jsonEncode({
      "application": app,
      "organization": organization,
      "username": account,
      // "name": ,
      "code": code,
      "type": "login"
    });

    var resp = await post("/api/verify-code", body: body);
    if (resp.code != 200) {
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${resp.code}");
    }
    if (resp.status == "error") {
      throw CASAuthError(
          ErrorLevel.error, resp.message ?? "none verifyCode error message");
    }
    return (resp.status == "ok", resp.cookie);
  }

  Future<AuthResult> setPassword(
      String userName, String code, String newPassword, String? cookie) async {
    String body =
        "userOwner=$organization&userName=$userName&code=$code&newPassword=$newPassword";
    Map<String, String> extHeaders = {
      "content-type": "application/x-www-form-urlencoded"
    };
    debugPrint("🔥 setPassword body: $body");
    var resp = await post("/api/set-password",
        body: body, extHeaders: extHeaders, cookie: cookie);
    if (resp.code != 200) {
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${resp.code}");
    }
    if (resp.status == "error") {
      debugPrint("🔥 setPassword error: ${resp.jsonBody}");
      // throw CASAuthError(
      //     ErrorLevel.error, resp.message ?? "none setPassword error message");
    }
    return resp;
  }
}
