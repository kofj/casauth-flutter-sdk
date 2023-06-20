part of casauth;

extension UserMethods on CASAuth {
  String? get token => _token;
  Future<void> setToken(String? token) async {
    _token = token;
    await vault?.put("token", token);
  }

  bool get isLogin => token != null && token != "";

  // get user from cache
  get currentUser => _user;
  Future<void> setUser(User? user) async {
    _user = user;
    await vault?.put("user", jsonEncode(user));
  }

  Future logout() async {
    AuthResult resp = await get(
        '/api/logout?id_token_hint=$token&post_logout_redirect_uri=$redirectUri');

    if (resp.code == 200 && resp.jsonBody?["status"] == "error") {
      debugPrint("🔥 server error: ${resp.jsonBody?["msg"]}");
      _token = "";
      await vault?.remove("user");
      await vault?.remove("token");
    }

    if (resp.code == 200 && resp.jsonBody?['data'] == "Affected") {
      debugPrint("🔥 success");
      _token = "";
      await vault?.remove("user");
      await vault?.remove("token");
    }

    debugPrint("🔥 logout ${resp.code}, body: ${resp.jsonBody}");
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
      log("token is not empty, logout before login");
      await logout();
    }

    AuthResult resp = await post('/api/login', payload);
    if (resp.code != 200) {
      throw CASAuthError(
          ErrorLevel.error, "server failed, http code: ${resp.code}");
    }

    if (resp.status == "error") {
      debugPrint(
          "🤬 login failed, response code ${resp.code}, body: ${resp.jsonBody}");
      throw CASAuthError(ErrorLevel.error, resp.message!);
    }
    if (resp.code == 200 && resp.status == "ok") {
      setToken(resp.jsonBody?['data']);
    }

    return resp;
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
      'createdTime': createdTime,
      'updatedTime': updatedTime,
    };
  }
}
