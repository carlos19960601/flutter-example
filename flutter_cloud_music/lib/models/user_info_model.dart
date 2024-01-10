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
}

class AvatarDetail extends Object {
  int userType;
  int identityLevel;
  String identityIconUrl;

  AvatarDetail(this.userType, this.identityIconUrl, this.identityLevel);
}
