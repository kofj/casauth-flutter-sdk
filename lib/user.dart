part of casauth;

extension UserMethods on CASAuth {
  String? get token => _token;
  Future<void> setToken(String? token) async {
    _token = token;
    await vault?.put("token", token);
  }

  bool get isLogin => token != null && token != "";
}
