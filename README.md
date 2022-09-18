# casauth

![CASAuth Logo](./images/casauth-banner.png)

A third Flutter client SDK for casdoor. Support follow platform:

| platform | tested | example |
| ---| ---| ---|
| iOS | ✅ | [App Store]() | 
| macOS | ✅ | [Download]() |
| linux | [-] | - |
| Windows | [-] | - |

## Prepare
You need install self's casdoor first. And I only test this SDK with a little version.

| CASAuth Version | Casdoor Version | Tested |
|---|---|---|
| v1.1.0 | v1.97.0 | ✅ |


## Usage

In the [example](example) folder has a full app example develop with Flutter v3.3.0 and Casdoor. I will show howto use this SDK follow:

### initiate

```dart
import 'package:casauth/casauth.dart';

String appId = "some-app-id";
String appName = "app-example";
String orgnazationName = "casbin";
String server = "https://door.casdoor.com";
CASAuth(
  appName,
  appId,
  server,
  orgnazationName,
);
```

### login

```dart
AuthResult resp =  AuthClient.loginByUserName(username, password);
```

### register

Register new user only with `username` and `password`. If `displayName` is required by casdoor, it will be same with `username`.
```dart
AuthResult resp = await AuthClient.registerByUserName(username, password);

if (resp.status == "error") {
  // handle error
  log("signup failed, error: ${resp.message}, body: ${resp.jsonBody}");
} else {
  // that's ok
}
```

Regsiter new user with `email` and `verification code`, `username`, `password` and `displayName` is optional. if `username` adn `password` is required by casdoor, it will be filled with random string.

```dart
AuthResult resp = await AuthClient.registerByEmail(
  email,
  verifyCode,
  username: username,
  password: password,
);

if (resp.status == "error") {
  // handle error
  log("signup failed, error: ${resp.message}, body: ${resp.jsonBody}");
} else {
  // that's ok
}
```

Regsiter new user with `phone` and `verification code`, `username`, `password` and `displayName` is optional.

```dart
AuthResult resp = await AuthClient.registerByPhone(
  phone,
  verifyCode,
  username: username,
  password: password,
);

if (resp.status == "error") {
  // handle error
  log("signup failed, error: ${resp.message}, body: ${resp.jsonBody}");
} else {
  // that's ok
}
```

# APIs

  - [Authentication APIs](#authentication-apis)
    - [Register by username](#register-by-username)
    - [Register by email](#register-by-email)
    - [Register by phone](#register-by-phone)
    - [Login by username](#login-by-username)
    - [Login by verification code](#login-by-verification-code)
    - [Logout](#logout)
    - [Get Captcha](#get-captcha)
    - [Send verification code](#send-verification-code)
    - [Fetch current user info](#fetch-current-user-info)



## Authentication APIs

### Register by username
```dart
static Future<AuthResult> registerByUserName(
  String username,
  String password, {
  String displayName = "",
}) async
```

### Register by email
```dart
static Future<AuthResult> registerByEmail(
  String email,
  String code, {
  String username = '',
  String password = '',
  String displayName = '',
}) async
```


### Register by phone
```dart
static Future<AuthResult> registerByPhone(
  String phone,
  String code, {
  String username = '',
  String password = '',
  String displayName = '',
  String countryCode = "86",
}) async
```

### Login by username
```dart
static Future<AuthResult> loginByUserName(
  String username,
  String password, {
  bool autoSignin = false,
}) async
```

### Login by verification code
```dart
static Future<AuthResult> loginByCode(
  String phoneOrEmail,
  String code, {
  AccountType type = AccountType.phone,
  bool autoSignin = false,
  String countryCode = "86",
}) async
```

### Logout
```dart
static Future<AuthResult?> logout() async
```

### Get Captcha
```dart
static Future<CaptchaResult> getCaptcha() async {
```

### Send verification code
```dart
static Future<AuthResult> sendCode(
  String dest, {
  AccountType? type = AccountType.phone,
  String? checkId = "",
  String? checkKey = "",
  String? checkType = "none",
  String? checkUser = "",
}) async
```

### Fetch current user info
```dart
static Future<void> userInfo() async
```

# License
