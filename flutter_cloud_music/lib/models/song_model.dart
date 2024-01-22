import 'package:flutter_cloud_music/models/privilege_model.dart';

class Song {
  String name;
  int id;
  List<Ar> ar;
  List<String> alia;
  int fee;
  int v;
  int st;
  AlbumSimple al;
  int? copyright;
  int? originCoverType;
  int? mv;
  PrivilegeModel? privilege;
  String? actionType;
  OriginSongSimpleData? originSongSimpleData;
  String? reason;
  Song(
    this.name,
    this.id,
    this.ar,
    this.alia,
    this.fee,
    this.v,
    this.al,
    this.copyright,
    this.originCoverType,
    this.mv,
    this.privilege,
    this.actionType,
    this.originSongSimpleData,
    this.st,
  );

  factory Song.fromJson(Map<String, dynamic> json) => Song(
        json['name'] as String,
        json['id'] as int,
        (json['ar'] as List<dynamic>)
            .map((e) => Ar.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
        (json['alia'] as List<dynamic>).map((e) => e as String).toList(),
        json['fee'] as int,
        json['v'] as int,
        AlbumSimple.fromJson(Map<String, dynamic>.from(json['al'])),
        json['copyright'] as int?,
        json['originCoverType'] as int?,
        json['mv'] as int?,
        json['privilege'] == null
            ? null
            : PrivilegeModel.fromJson(
                Map<String, dynamic>.from(json['privilege'])),
        json['actionType'] as String?,
        json['originSongSimpleData'] == null
            ? null
            : OriginSongSimpleData.fromJson(
                Map<String, dynamic>.from(json['originSongSimpleData'])),
        json['st'] as int,
      );

  bool canPlay() {
    return true;
  }
}

class Ar {
  int id;
  String? name;
  List<dynamic>? tns;
  List<dynamic>? alias;
  String? picUrl;
  bool? followed;
  int? accountId;
  int? fansCount;

  Ar(
    this.id,
    this.name,
    this.tns,
    this.alias,
    this.picUrl,
    this.followed,
    this.accountId,
    this.fansCount,
  );

  factory Ar.fromJson(Map<String, dynamic> json) => Ar(
        json['id'] as int,
        json['name'] as String?,
        json['tns'] as List<dynamic>?,
        json['alias'] as List<dynamic>?,
        json['picUrl'] as String?,
        json['followed'] as bool?,
        json['accountId'] as int?,
        json['fansCount'] as int?,
      );
}

class AlbumSimple {
  int id;
  String? name;
  String? picUrl;
  String? picStr;

  AlbumSimple(this.id, this.name, this.picUrl, this.picStr);

  factory AlbumSimple.fromJson(Map<String, dynamic> json) => AlbumSimple(
        json['id'] as int,
        json['name'] as String?,
        json['picUrl'] as String?,
        json['pic_str'] as String?,
      );
}

class OriginSongSimpleData extends Object {
  List<Ar> artists;

  OriginSongSimpleData(this.artists);

  factory OriginSongSimpleData.fromJson(Map<String, dynamic> json) =>
      OriginSongSimpleData(
        (json['artists'] as List<dynamic>)
            .map((e) => Ar.fromJson(Map<String, dynamic>.from(e)))
            .toList(),
      );
}
