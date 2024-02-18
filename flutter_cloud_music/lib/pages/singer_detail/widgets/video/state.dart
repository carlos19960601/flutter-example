import 'package:flutter_cloud_music/pages/found/models/shuffle_log_model.dart';

class VideoModel {
  final String id;

  final String? coverUrl;

  final MLogResource? resource;

  const VideoModel({required this.id, this.coverUrl, this.resource});

  @override
  String toString() {
    return 'VideoModel{id: $id, coverUrl: $coverUrl, resource: $resource}';
  }
}
