import 'package:flutter_cloud_music/models/privilege_model.dart';
import 'package:music_player/music_player.dart';

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

  factory Song.fromMetadata(MusicMetadata metadata) {
    return Song.fromJson(metadata.extras!.cast<String, dynamic>());
  }

  bool canPlay() {
    return true;
  }

  String getSongCellSubTitle() {
    final ars =
        ar.map((e) => e.name!).reduce((value, element) => '$value/$element');
    String str = '$ars - ${al.name}';
    if (originSongSimpleData != null) {
      final originArs = originSongSimpleData!.artists
          .map((e) => e.name)
          .reduce((value, element) => '$value/$element');
      str += ' ｜ 原唱：$originArs';
    }
    return str;
  }

  MusicMetadata? _metadata;

  MusicMetadata get metadata {
    _metadata ??= MusicMetadata(
        mediaId: id.toString(),
        title: name +
            (alia.isNotEmpty
                ? alia.reduce((value, element) => '$value $element')
                : ''),
        subtitle: arString(),
        iconUri: al.picUrl,
        extras: toJson());
    return _metadata!;
  }

  String arString() {
    return ar.map((e) => e.name!).reduce((value, element) => '$value/$element');
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'id': id,
        'ar': ar.map((e) => e.toJson()).toList(),
        'alia': alia,
        'fee': fee,
        'v': v,
        'st': st,
        'al': al.toJson(),
        'copyright': copyright,
        'originCoverType': originCoverType,
        'mv': mv,
        'privilege': privilege?.toJson(),
        'actionType': actionType,
        'originSongSimpleData': originSongSimpleData?.toJson(),
      };
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'tns': tns,
        'alias': alias,
        'picUrl': picUrl,
        'followed': followed,
        'accountId': accountId,
        'fansCount': fansCount,
      };
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'picUrl': picUrl,
        'pic_str': picStr,
      };
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'artists': artists.map((e) => e.toJson()).toList(),
      };
}

extension MusicListExt on List<Song> {
  List<MusicMetadata> toMetadataList() {
    return map((e) => e.metadata).toList();
  }
}
