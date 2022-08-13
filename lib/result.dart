class HttpResult {
  late int code;
  late String? status = "";
  late String? message = "";
  late Map<String, dynamic>? jsonBody;

  HttpResult(int respCode,
      {String? respStatus, String? respMessage, Map<String, dynamic>? body}) {
    code = respCode;
    status = respStatus;
    message = respMessage;
    jsonBody = body;
  }
}

class CaptchaResult {
  late int code;
  late String? status = "";
  late String? message = "";
  late CaptchaInfo? captcha;

  CaptchaResult(HttpResult httpResult) {
    code = httpResult.code;
    status = httpResult.status;
    message = httpResult.message;
    if (code == 200 && httpResult.jsonBody != null) {
      captcha = CaptchaInfo.fromJson(httpResult.jsonBody?['data']);
    }
  }
}

class CaptchaInfo {
  late String type;
  late String captchaId = "";
  late String? captchaImage;

  late String? scene;
  late String? appKey;
  late String? subType;
  late String? clientId;
  late String? clientId2;
  late String? clientSecret;
  late String? clientSecret2;

  CaptchaInfo.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    captchaId = json['captchaId'];
    captchaImage = json['captchaImage'];

    scene = json['scene'];
    appKey = json['appKey'];
    subType = json['subType'];
    clientId = json['clientId'];
    clientId2 = json['clientId2'];
    clientSecret = json['clientSecret'];
    clientSecret2 = json['clientSecret2'];
  }
}
