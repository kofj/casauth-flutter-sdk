part of casauth;

extension CasVault on CASAuth {
  Future<void> clearCache() async {
    _user = null;
    await vault?.remove("user");
    _token = null;
    await vault?.remove("token");
  }
}
