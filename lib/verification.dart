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
    Map<String, String> extHeader = {
      "content-type": "application/x-www-form-urlencoded"
    };

    var resp = await post("/api/send-verification-code", body, extHeader);
    if (resp.code != 200) {
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${resp.code}");
    }
    if (resp.status == "error") {
      throw CASAuthError(ErrorLevel.error, resp.message!);
    }
    return resp;
  }

  Future<bool> verifyCode(String account, String code) async {
    String body = jsonEncode({
      "application": app,
      "organization": organization,
      "username": account,
      // "name": ,
      "code": code,
      "type": "login"
    });

    var resp = await post("/api/verify-code", body);
    if (resp.code != 200) {
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${resp.code}");
    }
    if (resp.status == "error") {
      throw CASAuthError(ErrorLevel.error, resp.message!);
    }
    return resp.status == "ok";
  }
}
