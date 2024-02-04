import 'package:flutter_cloud_music/models/user_detail_model.dart';
import 'package:flutter_cloud_music/models/user_info_model.dart';
import 'package:flutter_cloud_music/pages/singer_detail/state.dart';

class SingerDetailModel extends Object {
  int videoCount;
  Identify? identify;
  Artist artist;
  int? eventCount;
  UserInfo? user;
  List<SecondaryExpertIdentiy>? secondaryExpertIdentiy;
  UserDetailModel? userDetailModel;

  SingerDetailModel(
    this.videoCount,
    this.identify,
    this.artist,
    this.eventCount,
    this.user,
    this.secondaryExpertIdentiy,
  );

  factory SingerDetailModel.fromJson(Map<String, dynamic> json) =>
      SingerDetailModel(
        json['videoCount'] as int,
        json['identify'] == null
            ? null
            : Identify.fromJson(json['identify'] as Map<String, dynamic>),
        Artist.fromJson(json['artist'] as Map<String, dynamic>),
        json['eventCount'] as int?,
        json['user'] == null
            ? null
            : UserInfo.fromJson(json['user'] as Map<String, dynamic>),
        (json['secondaryExpertIdentiy'] as List<dynamic>?)
            ?.map((e) =>
                SecondaryExpertIdentiy.fromJson(e as Map<String, dynamic>))
            .toList(),
      )..userDetailModel = json['userDetailModel'] == null
          ? null
          : UserDetailModel.fromJson(
              json['userDetailModel'] as Map<String, dynamic>,
            );

  SingerOrUserDetail? _detail;

  SingerOrUserDetail get detail {
    _detail ??= SingerOrUserDetail(true, this, userDetailModel);
    return _detail!;
  }
}

class Artist extends Object {
  int id;
  String cover;
  String name;
  String briefDesc;
  int albumSize;
  int musicSize;
  int mvSize;
  bool? followed;

  Artist(
    this.id,
    this.cover,
    this.name,
    this.briefDesc,
    this.albumSize,
    this.musicSize,
    this.mvSize,
    this.followed,
  );

  factory Artist.fromJson(Map<String, dynamic> json) => Artist(
        json['id'] as int,
        json['cover'] as String,
        json['name'] as String,
        json['briefDesc'] as String,
        json['albumSize'] as int,
        json['musicSize'] as int,
        json['mvSize'] as int,
        json['followed'] as bool?,
      );
}

class Identify extends Object {
  String? imageUrl;
  String? imageDesc;
  String? actionUrl;

  Identify(
    this.imageUrl,
    this.imageDesc,
    this.actionUrl,
  );

  factory Identify.fromJson(Map<String, dynamic> json) => Identify(
        json['imageUrl'] as String?,
        json['imageDesc'] as String?,
        json['actionUrl'] as String?,
      );
}

class SecondaryExpertIdentiy extends Object {
  String name;

  SecondaryExpertIdentiy(this.name);

  factory SecondaryExpertIdentiy.fromJson(Map<String, dynamic> json) =>
      SecondaryExpertIdentiy(
        json['expertIdentiyName'] as String,
      );
}
