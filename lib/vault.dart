part of casauth;

extension CasVault on CASAuth {
  Future<void> clearCache() async {
    await vault?.clear();
  }
}
