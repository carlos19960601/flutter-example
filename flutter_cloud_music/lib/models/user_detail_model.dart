import 'package:flutter_cloud_music/models/singer_detail_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';

class UserDetailModel extends Object {
  Identify? identify;
  int level;
  int listenSongs;
  Profile profile;
  int createTime;
  int createDays;
  ProfileVillageInfo? profileVillageInfo;
  SingerDetailModel? singerModel;

  UserDetailModel(
    this.identify,
    this.level,
    this.listenSongs,
    this.profile,
    this.createTime,
    this.createDays,
    this.profileVillageInfo,
  );

  factory UserDetailModel.fromJson(Map<String, dynamic> json) =>
      UserDetailModel(
        json['identify'] == null
            ? null
            : Identify.fromJson(json['identify'] as Map<String, dynamic>),
        json['level'] as int,
        json['listenSongs'] as int,
        Profile.fromJson(json['profile'] as Map<String, dynamic>),
        json['createTime'] as int,
        json['createDays'] as int,
        json['profileVillageInfo'] == null
            ? null
            : ProfileVillageInfo.fromJson(
                json['profileVillageInfo'] as Map<String, dynamic>),
      )..singerModel = json['singerModel'] == null
          ? null
          : SingerDetailModel.fromJson(
              json['singerModel'] as Map<String, dynamic>,
            );

  SingerOrUserDetail? _detail;

  SingerOrUserDetail get detail {
    _detail ??= SingerOrUserDetail(profile.artistId != null, null, this);
    return _detail!;
  }

  bool isSinger() {
    return profile.artistId != null;
  }
}

class ProfileVillageInfo extends Object {
  String title;
  String? imageUrl;
  String? targetUrl;

  ProfileVillageInfo(
    this.title,
    this.imageUrl,
    this.targetUrl,
  );

  factory ProfileVillageInfo.fromJson(Map<String, dynamic> json) =>
      ProfileVillageInfo(
        json['title'] as String,
        json['imageUrl'] as String?,
        json['targetUrl'] as String?,
      );
}

class Profile extends Object {
  int userType;
  int authStatus;
  String description;
  int userId;
  int birthday;
  int gender;
  String nickname;
  String avatarUrl;
  String backgroundUrl;
  int city;
  bool followed;
  String signature;
  int followeds;
  int follows;
  int eventCount;
  bool followMe;
  int playlistCount;
  int? artistId;
  String? artistName;

  Profile(
    this.userType,
    this.authStatus,
    this.description,
    this.userId,
    this.birthday,
    this.gender,
    this.nickname,
    this.avatarUrl,
    this.backgroundUrl,
    this.city,
    this.followed,
    this.signature,
    this.followeds,
    this.follows,
    this.eventCount,
    this.followMe,
    this.playlistCount,
    this.artistId,
    this.artistName,
  );

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        json['userType'] as int,
        json['authStatus'] as int,
        json['description'] as String,
        json['userId'] as int,
        json['birthday'] as int,
        json['gender'] as int,
        json['nickname'] as String,
        json['avatarUrl'] as String,
        json['backgroundUrl'] as String,
        json['city'] as int,
        json['followed'] as bool,
        json['signature'] as String,
        json['followeds'] as int,
        json['follows'] as int,
        json['eventCount'] as int,
        json['followMe'] as bool,
        json['playlistCount'] as int,
        json['artistId'] as int?,
        json['artistName'] as String?,
      );

  String getGenderStr() {
    return gender == 2
        ? '女'
        : gender == 1
            ? '男'
            : '';
  }
}
