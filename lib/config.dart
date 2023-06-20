part of casauth;

AppConfig configFromJson(String str) => AppConfig.fromJson(json.decode(str));

String configToJson(AppConfig data) => json.encode(data.toJson());

extension FetchAppConfig on CASAuth {
  // retrieve application config from server
  Future<AppConfig> fetchAppConfig() async {
    Map<String, String> headers = {
      "x-app-id": appId,
      "x-request-from": "casauth-sdk-flutter",
      "x-casauth-sdk-version": version,
      "content-type": "application/json",
    };

    var endpoint = Uri.parse("$server/api/get-application?id=admin/$app");
    debugPrint("fetch app config → $endpoint");

    var resp = await http.get(endpoint, headers: headers);
    debugPrint("fetch app config ← ${resp.statusCode}");
    if (resp.statusCode != 200) {
      log("init config failed: code=${resp.statusCode}/body=${resp.body.length} bytes");
      throw CASAuthError(ErrorLevel.fatal,
          "Failed to retrieve application config. resp code=${resp.statusCode}/body=${resp.body}");
    }
    if (resp.body == "null" || resp.body.isEmpty) {
      throw CASAuthError(ErrorLevel.fatal,
          "Failed to retrieve application config. body is empty");
    }
    return configFromJson(resp.body);
  }
}

class AppConfig {
  String owner = "";
  String name = "";
  DateTime createdTime = DateTime(1970);
  String displayName = "";
  String logo = "";
  String homepageUrl = "";
  String description = "";
  String organization = "";
  String cert = "";
  bool enablePassword = false;
  bool enableSignUp = false;
  bool enableSigninSession = false;
  bool enableCodeSignin = false;
  bool enableSamlCompress = false;
  bool enableWebAuthn = false;
  List<ProviderElement> providers = [];
  List<SignupItem> signupItems = [];
  List<String> grantTypes = [];
  //
  String clientId = "";
  String clientSecret = "";
  List<String> redirectUris = [];
  String tokenFormat = "";
  int expireInHours = 0;
  int refreshExpireInHours = 0;
  String signupUrl = "";
  String signinUrl = "";
  String forgetUrl = "";
  String affiliationUrl = "";
  String termsOfUse = "";
  String signupHtml = "";
  String signinHtml = "";

  @override
  String toString() {
    return toJson().toString();
  }

  AppConfig.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return;
    }
    owner = json["owner"];
    name = json["name"];
    createdTime = DateTime.parse(json["createdTime"]);
    displayName = json["displayName"];
    logo = json["logo"];
    homepageUrl = json["homepageUrl"];
    description = json["description"];
    organization = json["organization"];
    cert = json["cert"];
    enablePassword = json["enablePassword"];
    enableSignUp = json["enableSignUp"];
    enableSigninSession = json["enableSigninSession"];
    enableCodeSignin = json["enableCodeSignin"];
    enableSamlCompress = json["enableSamlCompress"];
    enableWebAuthn = json["enableWebAuthn"];
    providers = List<ProviderElement>.from(
      json["providers"].map((x) => ProviderElement.fromJson(x)),
    );
    signupItems = List<SignupItem>.from(
      json["signupItems"].map((x) => SignupItem.fromJson(x)),
    );
    grantTypes = List<String>.from(json["grantTypes"].map((x) => x));
    // organizationObj = OrganizationObj.fromJson(json["organizationObj"]);
    clientId = json["clientId"];
    clientSecret = json["clientSecret"];
    redirectUris = List<String>.from(json["redirectUris"].map((x) => x));
    tokenFormat = json["tokenFormat"];
    expireInHours = json["expireInHours"];
    refreshExpireInHours = json["refreshExpireInHours"];
    signupUrl = json["signupUrl"];
    signinUrl = json["signinUrl"];
    forgetUrl = json["forgetUrl"];
    affiliationUrl = json["affiliationUrl"];
    termsOfUse = json["termsOfUse"];
    signupHtml = json["signupHtml"];
    signinHtml = json["signinHtml"];
  }

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "name": name,
        "createdTime": createdTime.toIso8601String(),
        "displayName": displayName,
        "logo": logo,
        "homepageUrl": homepageUrl,
        "description": description,
        "organization": organization,
        "cert": cert,
        "enablePassword": enablePassword,
        "enableSignUp": enableSignUp,
        "enableSigninSession": enableSigninSession,
        "enableCodeSignin": enableCodeSignin,
        "enableSamlCompress": enableSamlCompress,
        "enableWebAuthn": enableWebAuthn,
        "providers": List<dynamic>.from(providers.map((x) => x.toJson())),
        "signupItems": List<dynamic>.from(signupItems.map((x) => x.toJson())),
        "grantTypes": List<String>.from(grantTypes.map((x) => x)),
        "clientId": clientId,
        "clientSecret": clientSecret,
        "redirectUris": List<dynamic>.from(redirectUris.map((x) => x)),
        "tokenFormat": tokenFormat,
        "expireInHours": expireInHours,
        "refreshExpireInHours": refreshExpireInHours,
        "signupUrl": signupUrl,
        "signinUrl": signinUrl,
        "forgetUrl": forgetUrl,
        "affiliationUrl": affiliationUrl,
        "termsOfUse": termsOfUse,
        "signupHtml": signupHtml,
        "signinHtml": signinHtml,
      };

  bool hasSignupItem(String name) {
    if (signupItems.isEmpty) {
      return false;
    }
    for (SignupItem item in signupItems) {
      if (item.name == name) {
        return true;
      }
    }
    return false;
  }

  bool requiredSignupItem(String name) {
    if (signupItems.isEmpty) {
      return false;
    }
    for (SignupItem item in signupItems) {
      if (item.name == name && item.required) {
        return true;
      }
    }
    return false;
  }

  bool get hasSignupEmail => hasSignupItem("Email");
  bool get hasSignupPhone => hasSignupItem("Phone");
  bool get hasSignupUsername => hasSignupItem("Username");
  bool get hasSignupPassword => hasSignupItem("Password");
  bool get hasSignupDisplayName => hasSignupItem("Display name");

  bool get requiredSignupEmail => requiredSignupItem("Email");
  bool get requiredSignupPhone => requiredSignupItem("Phone");
  bool get requiredSignupUsername => requiredSignupItem("Username");
  bool get requiredSignupPassword => requiredSignupItem("Password");
  bool get requiredSignupDisplayName => requiredSignupItem("Display name");

  String getGrantTokenType() {
    if (grantTypes.isEmpty) {
      return "";
    }
    if (grantTypes.contains("token")) {
      return "token";
    }
    if (grantTypes.contains("id_token")) {
      return "id_token";
    }

    return "";
  }
}

class ProviderElement {
  String name = "";
  bool canSignUp = false;
  bool canSignIn = false;
  bool canUnlink = false;
  bool prompted = false;
  String alertType = "";
  ProviderProvider? provider;

  ProviderElement.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    canSignUp = json["canSignUp"];
    canSignIn = json["canSignIn"];
    canUnlink = json["canUnlink"];
    prompted = json["prompted"];
    alertType = json["alertType"];
    if (json['provider'] != null) {
      provider = ProviderProvider.fromJson(json["provider"]);
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "canSignUp": canSignUp,
        "canSignIn": canSignIn,
        "canUnlink": canUnlink,
        "prompted": prompted,
        "alertType": alertType,
        "provider": provider?.toJson(),
      };
}

class ProviderProvider {
  String owner = "";
  String name = "";
  DateTime createdTime = DateTime(1970);
  String displayName = "";
  String category = "";
  String type = "";
  String subType = "";
  String method = "";
  String clientId = "";
  String clientSecret = "";
  String clientId2 = "";
  String clientSecret2 = "";
  String cert = "";
  String customAuthUrl = "";
  String customScope = "";
  String customTokenUrl = "";
  String customUserInfoUrl = "";
  String customLogo = "";
  String host = "";
  int port = 0;
  String title = "";
  String content = "";
  String regionId = "";
  String signName = "";
  String templateCode = "";
  String appId = "";
  String endpoint = "";
  String intranetEndpoint = "";
  String domain = "";
  String bucket = "";
  String metadata = "";
  String idP = "";
  String issuerUrl = "";
  bool enableSignAuthnRequest = false;
  String providerUrl = "";

  ProviderProvider.fromJson(Map<String, dynamic> json) {
    owner = json["owner"];
    name = json["name"];
    createdTime = DateTime.parse(json["createdTime"]);
    displayName = json["displayName"];
    category = json["category"];
    type = json["type"];
    subType = json["subType"];
    method = json["method"];
    clientId = json["clientId"];
    clientSecret = json["clientSecret"];
    clientId2 = json["clientId2"];
    clientSecret2 = json["clientSecret2"];
    cert = json["cert"];
    customAuthUrl = json["customAuthUrl"];
    customScope = json["customScope"];
    customTokenUrl = json["customTokenUrl"];
    customUserInfoUrl = json["customUserInfoUrl"];
    customLogo = json["customLogo"];
    host = json["host"];
    port = json["port"];
    title = json["title"];
    content = json["content"];
    regionId = json["regionId"];
    signName = json["signName"];
    templateCode = json["templateCode"];
    appId = json["appId"];
    endpoint = json["endpoint"];
    intranetEndpoint = json["intranetEndpoint"];
    domain = json["domain"];
    bucket = json["bucket"];
    metadata = json["metadata"];
    idP = json["idP"];
    issuerUrl = json["issuerUrl"];
    enableSignAuthnRequest = json["enableSignAuthnRequest"];
    providerUrl = json["providerUrl"];
  }

  Map<String, dynamic> toJson() => {
        "owner": owner,
        "name": name,
        "createdTime": createdTime.toIso8601String(),
        "displayName": displayName,
        "category": category,
        "type": type,
        "subType": subType,
        "method": method,
        "clientId": clientId,
        "clientSecret": clientSecret,
        "clientId2": clientId2,
        "clientSecret2": clientSecret2,
        "cert": cert,
        "customAuthUrl": customAuthUrl,
        "customScope": customScope,
        "customTokenUrl": customTokenUrl,
        "customUserInfoUrl": customUserInfoUrl,
        "customLogo": customLogo,
        "host": host,
        "port": port,
        "title": title,
        "content": content,
        "regionId": regionId,
        "signName": signName,
        "templateCode": templateCode,
        "appId": appId,
        "endpoint": endpoint,
        "intranetEndpoint": intranetEndpoint,
        "domain": domain,
        "bucket": bucket,
        "metadata": metadata,
        "idP": idP,
        "issuerUrl": issuerUrl,
        "enableSignAuthnRequest": enableSignAuthnRequest,
        "providerUrl": providerUrl,
      };
}

class SignupItem {
  String name = "";
  bool visible = false;
  bool required = false;
  bool prompted = false;
  String rule = "";

  SignupItem.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    visible = json["visible"];
    required = json["required"];
    prompted = json["prompted"];
    rule = json["rule"];
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "visible": visible,
        "required": required,
        "prompted": prompted,
        "rule": rule,
      };
}
