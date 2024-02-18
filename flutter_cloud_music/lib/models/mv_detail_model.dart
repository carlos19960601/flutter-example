import 'package:flutter_cloud_music/models/video_detail_model.dart';

class MvDetailModel extends Object {
  int id;
  String name;
  int artistId;
  String artistName;
  String briefDesc;
  String? desc;
  String cover;
  int playCount;
  int subCount;
  int shareCount;
  int commentCount;
  int duration;
  List<MvArtists> artists;
  List<String>? alias;
  String commentThreadId;

  MvDetailModel(
    this.id,
    this.name,
    this.artistId,
    this.artistName,
    this.briefDesc,
    this.desc,
    this.cover,
    this.playCount,
    this.subCount,
    this.shareCount,
    this.commentCount,
    this.duration,
    this.artists,
    this.alias,
    this.commentThreadId,
  );

  factory MvDetailModel.fromJson(Map<String, dynamic> json) => MvDetailModel(
        json['id'] as int,
        json['name'] as String,
        json['artistId'] as int,
        json['artistName'] as String,
        json['briefDesc'] as String,
        json['desc'] as String?,
        json['cover'] as String,
        json['playCount'] as int,
        json['subCount'] as int,
        json['shareCount'] as int,
        json['commentCount'] as int,
        json['duration'] as int,
        (json['artists'] as List<dynamic>)
            .map((e) => MvArtists.fromJson(e as Map<String, dynamic>))
            .toList(),
        (json['alias'] as List<dynamic>?)?.map((e) => e as String).toList(),
        json['commentThreadId'] as String,
      );
}

class MvArtists extends Object {
  int id;
  String name;
  bool followed;
  String? img1v1Url;

  MvArtists(
    this.id,
    this.name,
    this.followed,
    this.img1v1Url,
  );

  factory MvArtists.fromJson(Map<String, dynamic> json) => MvArtists(
        json['id'] as int,
        json['name'] as String,
        json['followed'] as bool,
        json['img1v1Url'] as String?,
      );
}

extension MvDetailExt on MvArtists {
  VideoCreator toVideoCreator() {
    return VideoCreator(followed, id, name, img1v1Url ?? '', null);
  }
}
