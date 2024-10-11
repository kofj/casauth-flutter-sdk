# CASAuth
[![Build Status](https://github.com/kofj/casauth/actions/workflows/main.yml/badge.svg)](https://github.com/kofj/casauth/actions/workflows/main.yml)
[![Pub Package](https://img.shields.io/pub/v/casauth.svg?style=flat-square)](https://pub.dartlang.org/packages/casauth)
[![Coverage Status](https://codecov.io/gh/kofj/casauth/branch/master/graph/badge.svg?token=VusBJYgahl)](https://codecov.io/gh/kofj/casauth)
[![Package Documentation](https://img.shields.io/badge/doc-casauth-blue.svg)](https://www.dartdocs.org/documentation/casauth/latest)
[![Github Stars](https://img.shields.io/github/stars/kofj/casauth.svg)](https://github.com/kofj/casauth)
[![GitHub License](https://img.shields.io/badge/license-MIT-yellow.svg)](https://opensource.org/licenses/MIT)


![CASAuth Logo](./images/casauth-banner.png)

CASAuth V2. A third Flutter client SDK for casdoor. Support follow platform:

| platform | tested | example      |
| -------- | ------ | ------------ |
| iOS      | ✅      | -            |
| macOS    | ✅      | [Download]() |
| linux    | [-]    | -            |
| Windows  | [-]    | -            |

## Getting Started
You need install self's casdoor first. And I only test this SDK with a little version.

| Version | Casdoor Min | Casdoor Max |
| ------- | ----------- | ----------- |
| v2.0.0  | ✅ v1.308.0  | ✅ v1.344.0  |
| v2.1.0  | ✅ v1.308.0  | ✅ v1.344.0  |
| v2.2.0  | ✅ v1.308.0  | ✅ v1.344.0  |
| v2.3.0  | ✅ v1.308.0  | ✅ v1.344.0  |


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
- `logLevel`: Setting SDK logger print level. If app running at flutter's `kDebugMode` or `kProfileMode`, will print stack trace info to helps debug.

### Send code
When the user register or recover password, must send verification code to the target email/mobile phone.
```dart
try {
  AuthResult resp = await casauth.sendCode(email, type: AccountType.email);
} catch (e) {
  debugPrint("send code failed");
  print("error level: ${err.level}, message: ${err.message}");
}
```

### Signup/Register by phone
The method `registerByPhone` default support 🇨🇳 Chinese mobile phone number via paramter `countryCode=CN`.

```dart
try {
  AuthResult resp = await casauth.registerByPhone(phone, code, username: id, password: id);
  print("expect true: ${resp.code == 200}, and true: ${resp.status == "ok"}");
} on CASAuthError catch (err) {
  debugPrint("register user failed");
  print("error level: ${err.level}, message: ${err.message}");
}
```

### Signup/Register by email
```dart
try {
  AuthResult resp = await casauth.registerByEmail(email, code, username: id, password: id);
  print("expect true: ${resp.code == 200}, and true: ${resp.status == "ok"}");
} on CASAuthError catch (err) {
  debugPrint("register user failed");
  print("error level: ${err.level}, message: ${err.message}");
}
```

### Login by account
You can login with account, includes username/email/phone.
```dart
var email = "me@example.com";
var username = "me_example_com";
var password = "your_strong_password";
try {
  // email login
  AuthResult resp = await casauth.loginByAccount(email, password);
  // username login
  // resp = await casauth.loginByAccount(username, password);
  print("expect true: ${resp.code == 200}, and true: ${resp.status == "ok"}");
} on CASAuthError catch (err) {
  print("error level: ${err.level}, message: ${err.message}");
}
```

### Logout
We call `/api/logout` to revoke the JWT token. You'll always see the token in Casdoor, which expires in 0s. 

```dart
try {
  AuthResult resp = await casauth.logout();
  print("expect true: ${resp.code == 200}, and true: ${resp.status == "ok"}");
} on CASAuthError catch (err) {
  print("error level: ${err.level}, message: ${err.message}");
}

```

### delete self
Soft delete account by user self, this require organization allow user edit `Is deleted` config. The method not clean local token, you can cancelled it before logout with the authed token.
```dart
try {
  AuthResult resp = casauth.softDeleteAccount();
  print("expect true: ${resp.code == 200}, and true: ${resp.status == "ok"}");
} on CASAuthError catch (err) {
  print("error level: ${err.level}, message: ${err.message}");
}
```

### cancel delete self
Cancel soft delete account by user self, this require organization allow user edit `Is deleted` config.
```dart
try {
  AuthResult resp = casauth.cancelDeleteAccount();
  print("expect true: ${resp.code == 200}, and true: ${resp.status == "ok"}");
} on CASAuthError catch (err) {
  print("error level: ${err.level}, message: ${err.message}");
}
```

### Recovery password
To recovery user's password, we must call API with 4 steps:

1. get email and phone info from server via username/email/phone.
2. send verification code with account and account type.
3. verify code, get bool verified result and cookie.
4. reset password with username, code, new password and cookie.

🔥🔥🔥 IMPORTANT: `name` of `setPassword` MUST is username of casdoor, NOT email or phone.

```dart
try {
  // 1. get emailAndPhone
  var info = await casauth.getEmailAndPhone(email);

  // 2. send code
  await casauth.sendCode(email,
      type: AccountType.email, method: "forget");

  // 4. reset password
  await casauth.setPassword(info.name, code, password, cookie);

  // 3. verify code
  var (verified, cookie) = await casauth.verifyCode(email, code);

  // 4. reset password
  await casauth.setPassword(info.name, code, password, cookie);
} on CASAuthError catch (err) {
  print("error level: ${err.level}, message: ${err.message}");
}
```