import 'package:flutter_cloud_music/common/constants.dart';
import 'package:flutter_cloud_music/models/song_model.dart';
import 'package:flutter_cloud_music/models/user_info_model.dart';
import 'package:flutter_cloud_music/pages/found/models/shuffle_log_model.dart';

class PlaylistDetailModel {
  int code;
  Playlist playlist;

  PlaylistDetailModel(
    this.code,
    this.playlist,
  );

  factory PlaylistDetailModel.fromJson(Map<String, dynamic> json) =>
      PlaylistDetailModel(
        json['code'] as int,
        Playlist.fromJson(json['playlist'] as Map<String, dynamic>),
      );

  //是否是官方歌单
  bool isOfficial() {
    return playlist.officialPlaylistType == ALG_OP;
  }

  bool isVideoPl() {
    return playlist.specialType == 200;
  }

  String getTypename() {
    if (isVideoPl()) {
      return '视频歌单';
    } else {
      return '歌单';
    }
  }
}

class Playlist extends Object {
  int id;
  String name;
  String coverImgUrl;
  int trackCount;
  int specialType;
  int playCount;
  int trackNumberUpdateTime;
  int subscribedCount;
  int cloudTrackCount;
  bool ordered;
  String? description;
  String? updateFrequency;
  String? titleImageUrl;
  String? englishTitle;
  String? backgroundCoverUrl;
  List<dynamic> tags;
  int backgroundCoverId;
  List<UserInfo> subscribers;
  UserInfo creator;
  List<Song> tracks;
  List<TrackIds> trackIds;
  int shareCount;
  int commentCount;
  String? officialPlaylistType;
  bool? subscribed;
  List<MLogResource>? videos;

  Playlist(
    this.id,
    this.name,
    this.coverImgUrl,
    this.trackCount,
    this.specialType,
    this.playCount,
    this.trackNumberUpdateTime,
    this.subscribedCount,
    this.cloudTrackCount,
    this.ordered,
    this.description,
    this.updateFrequency,
    this.backgroundCoverUrl,
    this.titleImageUrl,
    this.englishTitle,
    this.tags,
    this.backgroundCoverId,
    this.subscribers,
    this.creator,
    this.tracks,
    this.trackIds,
    this.shareCount,
    this.commentCount,
    this.officialPlaylistType,
    this.subscribed,
    this.videos,
  );

  factory Playlist.fromJson(Map<String, dynamic> json) => Playlist(
        json['id'] as int,
        json['name'] as String,
        json['coverImgUrl'] as String,
        json['trackCount'] as int,
        json['specialType'] as int,
        json['playCount'] as int,
        json['trackNumberUpdateTime'] as int,
        json['subscribedCount'] as int,
        json['cloudTrackCount'] as int,
        json['ordered'] as bool,
        json['description'] as String?,
        json['updateFrequency'] as String?,
        json['backgroundCoverUrl'] as String?,
        json['titleImageUrl'] as String?,
        json['englishTitle'] as String?,
        json['tags'] as List<dynamic>,
        json['backgroundCoverId'] as int,
        (json['subscribers'] as List<dynamic>)
            .map((e) => UserInfo.fromJson(e as Map<String, dynamic>))
            .toList(),
        UserInfo.fromJson(json['creator'] as Map<String, dynamic>),
        (json['tracks'] as List<dynamic>)
            .map((e) => Song.fromJson(e as Map<String, dynamic>))
            .toList(),
        (json['trackIds'] as List<dynamic>)
            .map((e) => TrackIds.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['shareCount'] as int,
        json['commentCount'] as int,
        json['officialPlaylistType'] as String?,
        json['subscribed'] as bool?,
        (json['videos'] as List<dynamic>?)
            ?.map((e) => MLogResource.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}

class TrackIds extends Object {
  int id;

  TrackIds(
    this.id,
  );

  factory TrackIds.fromJson(Map<String, dynamic> json) => TrackIds(
        json['id'] as int,
      );
}
