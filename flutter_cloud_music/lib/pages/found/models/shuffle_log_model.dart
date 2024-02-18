import 'package:flutter/material.dart';
import 'package:flutter_cloud_music/common/app_colors.dart';
import 'package:flutter_cloud_music/common/utils/theme_utils.dart';

class MLogResource extends Object {
  MlogBaseData mlogBaseData;
  MlogExtVO mlogExtVO;
  String shareUrl;
  VideoUserProfile? userProfile;

  MLogResource(
    this.mlogBaseData,
    this.mlogExtVO,
    this.shareUrl,
    this.userProfile,
  );

  factory MLogResource.fromJson(Map<String, dynamic> json) => MLogResource(
        MlogBaseData.fromJson(json['mlogBaseData'] as Map<String, dynamic>),
        MlogExtVO.fromJson(json['mlogExtVO'] as Map<String, dynamic>),
        json['shareUrl'] as String,
        json['userProfile'] == null
            ? null
            : VideoUserProfile.fromJson(
                json['userProfile'] as Map<String, dynamic>),
      );
}

class MlogBaseData extends Object {
  String id;
  int type;
  String text;
  String? desc;
  String coverUrl;
  int duration;
  int pubTime;

  MlogBaseData(
    this.id,
    this.type,
    this.text,
    this.desc,
    this.coverUrl,
    this.duration,
    this.pubTime,
  );

  factory MlogBaseData.fromJson(Map<String, dynamic> json) => MlogBaseData(
        json['id'] as String,
        json['type'] as int,
        json['text'] as String,
        json['desc'] as String?,
        json['coverUrl'] as String,
        json['duration'] as int,
        json['pubTime'] as int,
      );
}

class MlogExtVO extends Object {
  int likedCount;
  int commentCount;
  int? playCount;
  bool canCollect;
  VideoSong? song;

  MlogExtVO(
    this.likedCount,
    this.commentCount,
    this.playCount,
    this.canCollect,
    this.song,
  );

  factory MlogExtVO.fromJson(Map<String, dynamic> json) => MlogExtVO(
        json['likedCount'] as int,
        json['commentCount'] as int,
        json['playCount'] as int?,
        json['canCollect'] as bool,
        json['song'] == null
            ? null
            : VideoSong.fromJson(json['song'] as Map<String, dynamic>),
      );
}

class VideoSong {
  int id;
  String name;
  List<VideoSongArtists> artists;
  String albumName;

  VideoSong(
    this.id,
    this.name,
    this.artists,
    this.albumName,
  );

  factory VideoSong.fromJson(Map<String, dynamic> json) => VideoSong(
        json['id'] as int,
        json['name'] as String,
        (json['artists'] as List<dynamic>)
            .map((e) => VideoSongArtists.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['albumName'] as String,
      );
}

class VideoSongArtists extends Object {
  int artistId;
  String artistName;

  VideoSongArtists(
    this.artistId,
    this.artistName,
  );

  factory VideoSongArtists.fromJson(Map<String, dynamic> json) =>
      VideoSongArtists(
        json['artistId'] as int,
        json['artistName'] as String,
      );
}

class VideoUserProfile extends Object {
  int userId;
  String nickname;
  String avatarUrl;
  bool followed;

  VideoUserProfile(
    this.userId,
    this.nickname,
    this.avatarUrl,
    this.followed,
  );

  factory VideoUserProfile.fromJson(Map<String, dynamic> json) =>
      VideoUserProfile(
        json['userId'] as int,
        json['nickname'] as String,
        json['avatarUrl'] as String,
        json['followed'] as bool,
      );
}

extension MlogBaseDataExt on MlogBaseData {
  Widget buildNameView({int maxLine = 2}) {
    return RichText(
      text: TextSpan(
        children: [
          if (type == 3)
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Container(
                width: 20,
                height: 13,
                margin: const EdgeInsets.only(right: 3),
                decoration: const BoxDecoration(),
                alignment: Alignment.center,
                child: const Text(
                  "MV",
                  style: TextStyle(
                    color: AppColors.appMainLight,
                    fontSize: 8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          TextSpan(
              text: text,
              style: body2Style().copyWith(fontWeight: FontWeight.normal))
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
