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
HttpResult resp =  Client.loginByUserName(username, password);
```


```dart
HttpResult resp =  Client.loginByUserName(username, password);
```

### register

Register new user only with `username` and `password`. If `displayName` is required by casdoor, it will be same with `username`.
```dart
HttpResult resp = await Client.registerByUserName(username, password);

if (resp.status == "error") {
  // handle error
  log("signup failed, error: ${resp.message}, body: ${resp.jsonBody}");
} else {
  // that's ok
}
```

Regsiter new user with `email` and `verification code`, `username`, `password` and `displayName` is optional. if `username` adn `password` is required by casdoor, it will be filled with random string.

```dart
HttpResult resp = await Client.registerByEmail(
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
HttpResult resp = await Client.registerByPhone(
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
## License
