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
