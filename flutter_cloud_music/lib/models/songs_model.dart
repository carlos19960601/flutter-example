import 'package:flutter_cloud_music/models/privilege_model.dart';
import 'package:flutter_cloud_music/models/song_model.dart';

class SongsModel extends Object {
  List<Song> songs;
  List<PrivilegeModel> privileges;

  SongsModel(
    this.songs,
    this.privileges,
  );

  factory SongsModel.fromJson(Map<String, dynamic> json) => SongsModel(
        (json["songs"] as List<dynamic>)
            .map((e) => Song.fromJson(e as Map<String, dynamic>))
            .toList(),
        (json["privileges"] as List<dynamic>)
            .map((e) => PrivilegeModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
}
