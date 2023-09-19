part of casauth;

extension UserMethods on CASAuth {
  String? get token => _token;
  Future<void> setToken(String? token) async {
    _token = token;
    await vault?.put("token", token);
  }

  bool get isLogin => token != null && token != "";

  Future<void> setUser(User? user) async {
    _user = user;
    await vault?.put("user", jsonEncode(user));
  }

  Future<AuthResult> logout() async {
    if (token == null || token == "" || token == "null") {
      return AuthResult(200);
    }
    AuthResult resp = await get(
        '/api/logout?id_token_hint=$token&post_logout_redirect_uri=$redirectUri');

    if (resp.code == 200 && resp.jsonBody?['data'] == "Affected") {
      logger.v("⚠️  success");
      await clearCache();
    }

    if (resp.status == "error" && resp.message == "Access token has expired") {
      switch (resp.message) {
        case "Access token has expired":
          logger.d({
            "info": "logout",
            "code": resp.code,
            "status": resp.status,
            "jsonBody": resp.jsonBody,
            "token": token
          });
          await clearCache();

        default:
          logger.v({
            "info": "logout unknown error",
            "code": resp.code,
            "status": resp.status,
            "jsonBody": resp.jsonBody,
            "token": token
          });
          throw CASAuthError(ErrorLevel.error, resp.message!);
      }
    }

    if (resp.status == "error") {}

    return resp;
  }

  Future<AuthResult> loginByAccount(
    String username,
    String password, {
    bool autoSignin = false,
  }) async {
    var payload = jsonEncode({
      'username': username,
      'password': password,
      'appId': appId,
      'autoSignin': autoSignin,
      'application': app,
      'organization': organization,
      'type': appConfig!.getGrantTokenType(),
    });

    if (isLogin) {
      logger.w("token is not empty, auto logout");
      await logout();
    }

    AuthResult resp = await post('/api/login', body: payload);
    if (resp.code != 200) {
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${resp.code}");
    }

    if (resp.status == "error") {
      logger.d("🤬 login failed, code ${resp.code}, body: ${resp.jsonBody}");
      throw CASAuthError(ErrorLevel.error, resp.message!);
    }
    if (resp.code == 200 && resp.status == "ok") {
      logger.v("🔥 login success, body: ${resp.jsonBody}");
      setToken(resp.jsonBody?['data']);
    }

    // update user info
    await userInfo();

    return resp;
  }

  Future<AuthResult> registerByEmail(
    String email,
    String code, {
    String username = '',
    String password = '',
    String displayName = '',
  }) async {
    var requiredString = Xid().toString();
    if (username.isEmpty && appConfig!.requiredSignupUsername) {
      username = requiredString;
    }
    if (appConfig!.requiredSignupDisplayName || displayName.isEmpty) {
      displayName = email;
    }

    if (password.isEmpty && appConfig!.requiredSignupPassword) {
      password = requiredString;
    }

    var payload = jsonEncode({
      'email': email,
      'emailCode': code,
      'username': username,
      'name': displayName,
      'password': password,
      'appId': appId,
      'application': app,
      'organization': organization,
    });
    logger.v("🔥 registerByEmail payload: $payload");
    AuthResult resp = await post('/api/signup', body: payload);

    if (resp.code != 200) {
      logger.d("🤬 login failed, code ${resp.code}, body: ${resp.jsonBody}");
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${resp.code}");
    }

    if (resp.status == "error") {
      logger.d(
          "🤬 signup failed, message ${resp.message}, body: ${resp.jsonBody}");
      throw CASAuthError(ErrorLevel.error, resp.message!);
    }
    return resp;
  }

  Future<UserEmailPhone> getEmailAndPhone(String account) async {
    AuthResult response = await get(
        "/api/get-email-and-phone?organization=$organization&username=$account");

    if (response.code != 200) {
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${response.code}");
    }

    if (response.status == "error" &&
        response.message == "The user: $organization/$account doesn't exist") {
      throw CASAuthError(ErrorLevel.error, "user not exist");
    }

    if (response.status == "error") {
      throw CASAuthError(ErrorLevel.error, response.message!);
    }
    logger.v("🔥 getEmailAndPhone by $account: ${response.message}");
    return UserEmailPhone.fromJson(response.jsonBody?['data']);
  }

  Future<User> userInfo() async {
    AuthResult response = await get("/api/get-account");
    if (response.code != 200) {
      logger.d(
          "🤬 get user info failed, code ${response.code}, body: ${response.jsonBody}");
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${response.code}");
    }

    if (response.status == "error") {
      logger.d(
          "🤬 get user info failed, message ${response.message}, body: ${response.jsonBody}");
      throw CASAuthError(ErrorLevel.error, response.message!);
    }

    var user = User.fromJson(response.jsonBody?['data']);
    await setUser(user);
    return user;
  }

  Future<User> get currentUser async {
    // 1. get user from cache
    if (_user != null) {
      return _user!;
    }
    // 2. get user from server
    return await userInfo();
  }

  Future<AuthResult> softDeleteAccount() async {
    _user?.isDeleted = true;

    return updateAccount();
  }

  Future<AuthResult> cancelDeleteAccount() async {
    _user?.isDeleted = false;

    return updateAccount();
  }

  Future<AuthResult> updateAccount() async {
    var body = jsonEncode(_user);

    AuthResult response = await post(
      "/api/update-user",
      body: body.toString(),
    );
    if (response.code != 200) {
      logger.d(
          "🤬 update user failed, code ${response.code}, body: ${response.jsonBody}");
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${response.code}");
    }

    if (response.status == "error") {
      logger.d(
          "🤬 update user failed, message ${response.message}, body: ${response.jsonBody}");
      throw CASAuthError(ErrorLevel.error, response.message!);
    }
    // await clearCache();
    return response;
  }
}

enum AccountType { username, phone, email }

extension ParseToString on AccountType {
  String toShortString() {
    return name;
  }
}

class UserEmailPhone {
  String name = "";
  String? email;
  String? phone;
  UserEmailPhone({this.name = "", this.email, this.phone});
  UserEmailPhone.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
  }
}

class User {
  late String id;
  late String name;
  late String owner;
  late String avatar;
  late String displayName;
  late String email;
  late bool emailVerified;
  late String phone;
  late String location;
  late String title;
  late String idCardType;
  late String idCard;
  late String homepage;
  late String bio;
  late String region;
  late String gender;
  late int score;
  late int karma;
  late int ranking;
  late bool isDefaultAvatar;
  late bool isOnline;
  late bool isAdmin;
  late bool isGlobalAdmin;
  late bool isForbidden;
  late bool isDeleted;
  late String signupApplication;
  late String createdIp;
  late String lastSigninTime;
  late String lastSigninIp;
  late String type;
  late Map properties;

  late String createdTime;
  late String updatedTime;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    owner = json['owner'];
    avatar = json['avatar'];
    displayName = json['displayName'];
    email = json['email'];
    emailVerified = json['emailVerified'];
    phone = json['phone'];
    location = json['location'];
    title = json['title'];
    idCardType = json['idCardType'];
    idCard = json['idCard'];
    homepage = json['homepage'];
    bio = json['bio'];
    region = json['region'];
    gender = json['gender'];
    score = json['score'];
    karma = json['karma'];
    ranking = json['ranking'];
    isDefaultAvatar = json['isDefaultAvatar'];
    isOnline = json['isOnline'];
    isAdmin = json['isAdmin'];
    isGlobalAdmin = json['isGlobalAdmin'];
    isForbidden = json['isForbidden'];
    isDeleted = json['isDeleted'];
    signupApplication = json['signupApplication'];
    createdIp = json['createdIp'];
    lastSigninTime = json['lastSigninTime'];
    lastSigninIp = json['lastSigninIp'];
    type = json['type'];
    properties = json['properties'];

    createdTime = json['createdTime'];
    updatedTime = json['updatedTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'owner': owner,
      'avatar': avatar,
      'displayName': displayName,
      'email': email,
      'emailVerified': emailVerified,
      'phone': phone,
      'location': location,
      'title': title,
      'idCardType': idCardType,
      'idCard': idCard,
      'homepage': homepage,
      'bio': bio,
      'region': region,
      'gender': gender,
      'score': score,
      'karma': karma,
      'ranking': ranking,
      'isDefaultAvatar': isDefaultAvatar,
      'isOnline': isOnline,
      'isAdmin': isAdmin,
      'isGlobalAdmin': isGlobalAdmin,
      'isForbidden': isForbidden,
      'isDeleted': isDeleted,
      'signupApplication': signupApplication,
      'createdIp': createdIp,
      'lastSigninTime': lastSigninTime,
      'lastSigninIp': lastSigninIp,
      'type': type,
      'properties': properties,
      'createdTime': createdTime,
      'updatedTime': updatedTime,
    };
  }
}
