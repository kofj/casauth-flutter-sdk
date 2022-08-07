class HttpResult {
  late String message = "";
  late int code;
  late Map data;

  HttpResult(String msg, {int? codev, Map? datamap}) {
    message = msg;
    if (codev != null) {
      code = codev;
    }
    if (datamap != null) {
      data = datamap;
    }
  }
}
