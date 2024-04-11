import 'package:flutter_cloud_music/models/user_info_model.dart';

class VideoDetailModel {
  String vid;
  VideoCreator creator;
  String coverUrl;
  String title;
  String? description;
  int durationms;
  int playTime;
  int praisedCount;
  int commentCount;
  int shareCount;
  int subscribeCount;
  int publishTime;
  String avatarUrl;
  int width;
  int height;

  VideoDetailModel(
    this.vid,
    this.creator,
    this.coverUrl,
    this.title,
    this.description,
    this.durationms,
    this.playTime,
    this.praisedCount,
    this.commentCount,
    this.shareCount,
    this.subscribeCount,
    this.publishTime,
    this.avatarUrl,
    this.width,
    this.height,
  );

  factory VideoDetailModel.fromJson(Map<String, dynamic> json) =>
      VideoDetailModel(
        json['vid'] as String,
        VideoCreator.fromJson(json['creator'] as Map<String, dynamic>),
        json['coverUrl'] as String,
        json['title'] as String,
        json['description'] as String?,
        json['durationms'] as int,
        json['playTime'] as int,
        json['praisedCount'] as int,
        json['commentCount'] as int,
        json['shareCount'] as int,
        json['subscribeCount'] as int,
        json['publishTime'] as int,
        json['avatarUrl'] as String,
        json['width'] as int,
        json['height'] as int,
      );
}

class VideoCreator extends Object {
  bool followed;
  int userId;
  String nickname;
  String avatarUrl;
  AvatarDetail? avatarDetail;

  VideoCreator(
    this.followed,
    this.userId,
    this.nickname,
    this.avatarUrl,
    this.avatarDetail,
  );

  factory VideoCreator.fromJson(Map<String, dynamic> json) => VideoCreator(
        json['followed'] as bool,
        json['userId'] as int,
        json['nickname'] as String,
        json['avatarUrl'] as String,
        json['avatarDetail'] == null
            ? null
            : AvatarDetail.fromJson(
                json['avatarDetail'] as Map<String, dynamic>),
      );
}
