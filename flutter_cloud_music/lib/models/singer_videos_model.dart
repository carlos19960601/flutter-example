import 'package:flutter_cloud_music/pages/found/models/shuffle_log_model.dart';

class SingerVideosModel extends Object {
  List<Records> records;
  Page page;

  SingerVideosModel(
    this.records,
    this.page,
  );

  factory SingerVideosModel.fromJson(Map<String, dynamic> json) =>
      SingerVideosModel(
        (json['records'] as List<dynamic>)
            .map((e) => Records.fromJson(e as Map<String, dynamic>))
            .toList(),
        Page.fromJson(json['page'] as Map<String, dynamic>),
      );
}

class Records extends Object {
  String id;
  int type;
  MLogResource resource;
  bool sameCity;

  Records(
    this.id,
    this.type,
    this.resource,
    this.sameCity,
  );

  factory Records.fromJson(Map<String, dynamic> json) => Records(
        json['id'] as String,
        json['type'] as int,
        MLogResource.fromJson(json['resource'] as Map<String, dynamic>),
        json['sameCity'] as bool,
      );
}

class Page extends Object {
  int size;
  String cursor;
  bool more;

  Page(
    this.size,
    this.cursor,
    this.more,
  );

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        json['size'] as int,
        json['cursor'] as String,
        json['more'] as bool,
      );
}
