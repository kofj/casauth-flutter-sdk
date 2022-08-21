library casauth;

import "dart:math";

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

const _numbers = '1234567890';
Random _rnd2 = Random(DateTime.now().millisecondsSinceEpoch);
String randomNumberString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _numbers.codeUnitAt(_rnd2.nextInt(_numbers.length))));

enum AccountType { username, phone, email }

extension ParseToString on AccountType {
  String toShortString() {
    return toString().split('.').last;
  }
}

RegExp _isCnPhone = RegExp(r'^1[3456789]\d{9}$');

bool isCnPhoneNumber(String phone) {
  return _isCnPhone.hasMatch(phone);
}
