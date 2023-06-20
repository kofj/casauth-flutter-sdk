# CASAuth
[![Build Status](https://github.com/kofj/casauth/actions/workflows/main.yml/badge.svg)](https://github.com/kofj/casauth/actions/workflows/main.yml)
[![Pub Package](https://img.shields.io/pub/v/casauth.svg?style=flat-square)](https://pub.dartlang.org/packages/casauth)
[![Coverage Status](https://codecov.io/gh/kofj/casauth/branch/master/graph/badge.svg?token=VusBJYgahl)](https://codecov.io/gh/kofj/casauth)
[![Package Documentation](https://img.shields.io/badge/doc-casauth-blue.svg)](https://www.dartdocs.org/documentation/casauth/latest)
[![Github Stars](https://img.shields.io/github/stars/kofj/casauth.svg)](https://github.com/kofj/casauth)
[![GitHub License](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


![CASAuth Logo](./images/casauth-banner.png)

CASAuth V2. A third Flutter client SDK for casdoor. Support follow platform:

| platform | tested | example |
| ---| ---| ---|
| iOS | ✅ | - |
| macOS | ✅ | [Download]() |
| linux | [-] | - |
| Windows | [-] | - |

## Getting Started
You need install self's casdoor first. And I only test this SDK with a little version.

| Version | Casdoor Min | Casdoor Max |
|---|---|---|
| v1.1.0 |  ✅ v1.97.0 | - |
| v1.1.0 |  ✅ v1.123.0 | - |
| v1.2.0 |  ✅ v1.223.0 | - |
| v2.0.0 |  ✅ v1.308.0 | - |


## Quick Start
I will show howto use this SDK follow.

If casdoor server response `status` is **error** or `code` not `200`, the SDK will thorws `CASAuthError`, that has 3 error level `warn` /`error` / `fatal`. `warn` error dont need process; `error` will case current method/request failed only; when there has `fatal` error, your all methods calling maybe failed.

Before start calling methods, you MUST initiate the SDK.
### initiate
```dart
// init global instance
import 'package:casauth/casauth.dart';

String appId = "some-app-id";
String appName = "app-example";
String orgnazationName = "casbin";
String server = "https://door.casdoor.com";

try {
  //  Normally we use the default global instance to access casdoor.
  await init(appName, appId, server, orgnazationName);
  // Otherwise, you can create instance and manage it by your self.
  // var sdk = CASAuth(appName, appId, server, orgnazationName)
  // await sdk.init();
} catch (e) {
  debugPrint("init casauth SDK failed: $e");
}
```
`CASAuth` and global `init` method has optional parameters:
- `vault`: **Vault** of `Stash` package, CASAuth use it to cache token, user info etc. And we will default init sqlite database if not set `vault` parameter. You can initiate any `stash` Storage Implementations and create `vault` to customs storage for the SDK.
- `userPrefix`: Random user name prefix. Default value is **mobile_**.
- `redirectUri`: Address configured at Casdoor application config, the value must in the application's callback list. We use it to revoke/expired JWT token. Default value is **casauth**.

### Send code
When the user register or recover password, must send verification code to the target email/mobile phone.
```dart
try {
  AuthResult resp = await casauth.sendCode(email, type: AccountType.email);
} catch (e) {
  debugPrint("send code failed");
}
```

### Signup/Register by email
```dart
try {
  await casauth.registerByEmail(email, code, username: id, password: id);
} catch (e) {
  debugPrint("register user failed");
}
```
