part of casauth;

extension CasVault on CASAuth {
  Future<void> clearCache() async {
    await vault?.remove("user");
    await vault?.remove("token");
  }
}
