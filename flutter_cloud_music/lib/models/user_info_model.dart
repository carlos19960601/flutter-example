class UserInfo extends Object {
  bool followed;
  String avatarUrl;
  int gender;
  int birthday;
  int userId;
  String nickname;
  String? signature;
  String? description;
  String? detailDescription;
  String? backgroundUrl;
  String? remarkName;
  AvatarDetail? avatarDetail;

  UserInfo(
    this.followed,
    this.avatarUrl,
    this.gender,
    this.birthday,
    this.userId,
    this.nickname,
    this.signature,
    this.description,
    this.detailDescription,
    this.backgroundUrl,
    this.remarkName,
    this.avatarDetail,
  );

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        json['followed'] as bool,
        json['avatarUrl'] as String,
        json['gender'] as int,
        json['birthday'] as int,
        json['userId'] as int,
        json['nickname'] as String,
        json['signature'] as String?,
        json['description'] as String?,
        json['detailDescription'] as String?,
        json['backgroundUrl'] as String?,
        json['remarkName'] as String?,
        json['avatarDetail'] == null
            ? null
            : AvatarDetail.fromJson(
                json['avatarDetail'] as Map<String, dynamic>),
      );
}

class AvatarDetail extends Object {
  int userType;
  int identityLevel;
  String identityIconUrl;

  AvatarDetail(this.userType, this.identityIconUrl, this.identityLevel);

  factory AvatarDetail.fromJson(Map<String, dynamic> json) => AvatarDetail(
        json['userType'] as int,
        json['identityIconUrl'] as String,
        json['identityLevel'] as int,
      );
}
