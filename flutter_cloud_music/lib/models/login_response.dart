class LoginResponse {
  int loginType;
  int code;
  Account account;
  String token;
  Profile? profile;
  String cookie;

  LoginResponse(
    this.loginType,
    this.code,
    this.account,
    this.token,
    this.profile,
    this.cookie,
  );

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        json['loginType'] as int,
        json['code'] as int,
        Account.fromJson(json['account'] as Map<String, dynamic>),
        json['token'] as String,
        json['profile'] == null
            ? null
            : Profile.fromJson(json['profile'] as Map<String, dynamic>),
        json['cookie'] as String,
      );
}

class Account extends Object {
  int id;
  String userName;
  int type;
  int status;
  int whitelistAuthority;
  int createTime;
  String salt;
  int tokenVersion;
  int ban;
  int baoyueVersion;
  int donateVersion;
  int vipType;
  int viptypeVersion;
  bool anonimousUser;

  Account(
    this.id,
    this.userName,
    this.type,
    this.status,
    this.whitelistAuthority,
    this.createTime,
    this.salt,
    this.tokenVersion,
    this.ban,
    this.baoyueVersion,
    this.donateVersion,
    this.vipType,
    this.viptypeVersion,
    this.anonimousUser,
  );
  factory Account.fromJson(Map<String, dynamic> json) => Account(
        json['id'] as int,
        json['userName'] as String,
        json['type'] as int,
        json['status'] as int,
        json['whitelistAuthority'] as int,
        json['createTime'] as int,
        json['salt'] as String,
        json['tokenVersion'] as int,
        json['ban'] as int,
        json['baoyueVersion'] as int,
        json['donateVersion'] as int,
        json['vipType'] as int,
        json['viptypeVersion'] as int,
        json['anonimousUser'] as bool,
      );
}

class Profile extends Object {
  int userId;
  int userType;
  int city;
  String avatarUrl;
  int djStatus;
  bool followed;
  String backgroundUrl;
  String detailDescription;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  int vipType;
  int avatarImgId;
  String nickname;
  int accountStatus;
  int gender;
  int backgroundImgId;
  int birthday;
  String description;
  bool mutual;
  int authStatus;
  bool defaultAvatar;
  int province;
  String signature;
  int authority;
  int followeds;
  int follows;
  int eventCount;
  int playlistCount;
  int playlistBeSubscribedCount;

  Profile(
    this.userId,
    this.userType,
    this.city,
    this.avatarUrl,
    this.djStatus,
    this.followed,
    this.backgroundUrl,
    this.detailDescription,
    this.avatarImgIdStr,
    this.backgroundImgIdStr,
    this.vipType,
    this.avatarImgId,
    this.nickname,
    this.accountStatus,
    this.gender,
    this.backgroundImgId,
    this.birthday,
    this.description,
    this.mutual,
    this.authStatus,
    this.defaultAvatar,
    this.province,
    this.signature,
    this.authority,
    this.followeds,
    this.follows,
    this.eventCount,
    this.playlistCount,
    this.playlistBeSubscribedCount,
  );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        json['userId'] as int,
        json['userType'] as int,
        json['city'] as int,
        json['avatarUrl'] as String,
        json['djStatus'] as int,
        json['followed'] as bool,
        json['backgroundUrl'] as String,
        json['detailDescription'] as String,
        json['avatarImgIdStr'] as String,
        json['backgroundImgIdStr'] as String,
        json['vipType'] as int,
        json['avatarImgId'] as int,
        json['nickname'] as String,
        json['accountStatus'] as int,
        json['gender'] as int,
        json['backgroundImgId'] as int,
        json['birthday'] as int,
        json['description'] as String,
        json['mutual'] as bool,
        json['authStatus'] as int,
        json['defaultAvatar'] as bool,
        json['province'] as int,
        json['signature'] as String,
        json['authority'] as int,
        json['followeds'] as int,
        json['follows'] as int,
        json['eventCount'] as int,
        json['playlistCount'] as int,
        json['playlistBeSubscribedCount'] as int,
      );
}
