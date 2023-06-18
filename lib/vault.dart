import 'package:casauth/casauth.dart';

extension Vault on CASAuth {
  Future<void> clearCache() async {
    await CASAuth.defaultVault?.clear();
  }
}
