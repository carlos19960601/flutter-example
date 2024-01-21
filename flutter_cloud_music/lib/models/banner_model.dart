import 'package:flutter_cloud_music/models/song_model.dart';

class BannerModel {
  List<Banner> banner;

  BannerModel(
    this.banner,
  );

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        (json["banners"] as List<dynamic>)
            .map((e) => Banner.fromJson(e))
            .toList(),
      );
}

class Banner {
  String? bannerId;
  String? pic;
  String? titleColor;
  String? requestId;
  bool exclusive;
  String? scm;
  Song? song;
  int targetId;
  bool showAdTag;
  int targetType;
  String? typeTitle;
  String? url;
  String? encodeId;

  Banner(
    this.bannerId,
    this.pic,
    this.titleColor,
    this.requestId,
    this.exclusive,
    this.scm,
    this.song,
    this.targetId,
    this.showAdTag,
    this.targetType,
    this.typeTitle,
    this.url,
    this.encodeId,
  );

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
        json['bannerId'] as String?,
        json['pic'] as String?,
        json['titleColor'] as String?,
        json['requestId'] as String?,
        json['exclusive'] as bool,
        json['scm'] as String?,
        json['song'] == null
            ? null
            : Song.fromJson(json['song'] as Map<String, dynamic>),
        json['targetId'] as int,
        json['showAdTag'] as bool,
        json['targetType'] as int,
        json['typeTitle'] as String?,
        json['url'] as String?,
        json['encodeId'] as String?,
      );
}
